import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp_clone_flutter/common/provider/message_reply_provider.dart';
import 'package:whatsapp_clone_flutter/common/repositories/common_firebase_storage_repo.dart';
import 'package:whatsapp_clone_flutter/common/utils/utils.dart';
import 'package:whatsapp_clone_flutter/models/chat_contact.dart';
import 'package:whatsapp_clone_flutter/models/user_model.dart';
import '../../../common/enums/message_enum.dart';
import '../../../models/message_model.dart';

final chatRepositoryProvider = Provider((ref) => ChatRepository(
    firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance));

class ChatRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  ChatRepository({required this.firestore, required this.auth});

  Stream<List<ChatContact>> getChatContacts() {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .snapshots()
        .asyncMap((event) async {
      List<ChatContact> contacts = [];
      for (var document in event.docs) {
        var chatContact = ChatContact.fromMap(document.data());
        var userData = await firestore
            .collection('users')
            .doc(chatContact.contactId)
            .get();
        var user = UserModel.fromMap(userData.data()!);

        contacts.add(
          ChatContact(
            name: user.name,
            profilePic: user.profilePic,
            contactId: chatContact.contactId,
            timeSent: chatContact.timeSent,
            lastMessage: chatContact.lastMessage,
          ),
        );
      }
      return contacts;
    });
  }

  void _saveDataToContactsSubCollections(
      UserModel senderUserData,
      UserModel recieverUserData,
      String text,
      DateTime timeSent,
      String recieverUserId) async {
    /// users => reiever user id => chats => current user id =>set data
    var recieverChatContact = ChatContact(
        name: senderUserData.name,
        lastMessage: text,
        profilePic: senderUserData.profilePic,
        contactId: senderUserData.uid,
        timeSent: timeSent);
    await firestore
        .collection('users')
        .doc(recieverUserId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .set(recieverChatContact.toMap());

    /// users =>current user id => chats => reciever user id =>set data
    var senderChatContact = ChatContact(
        name: recieverUserData.name,
        lastMessage: text,
        profilePic: recieverUserData.profilePic,
        contactId: recieverUserData.uid,
        timeSent: timeSent);
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(recieverUserId)
        .set(senderChatContact.toMap());
  }

  void _saveMessageToMessageSubcollection(
      {required String recieverUserId,
      required String text,
      required DateTime timeSent,
      required String messageId,
      required String username,
      required String senderUsername,
      required String? recieverUserName,
      required MessageEnum messageType,
      required MessageReply? messageReply,

      }) async {
    final message = Message(
      senderId: auth.currentUser!.uid,
      recieverid: recieverUserId,
      text: text,
      type: messageType,
      timeSent: timeSent,
      messageId: messageId,
      isSeen: false,
      repliedMessage: messageReply== null
          ? ''
          : messageReply.message,
      repliedTo: messageReply == null
          ? ''
          : messageReply.isMe
          ? senderUsername
          : recieverUserName ?? '',
      repliedMessageType: messageReply == null
          ? MessageEnum.text
          : messageReply.messageEnum,
    );
    // users -> sender id -> reciever id -> messages -> message id -> store message
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(recieverUserId)
        .collection('messages')
        .doc(messageId)
        .set(
          message.toMap(),
        );
    // users -> reciever id  -> sender id -> messages -> message id -> store message
    await firestore
        .collection('users')
        .doc(recieverUserId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .collection('messages')
        .doc(messageId)
        .set(
          message.toMap(),
        );
  }

  void sendTextMessage({
    required BuildContext context,
    required String text,
    required String recieverUserId,
    required UserModel senderUser,
    required MessageReply messageReply,
  }) async {
    /// user-->sender id --> reciever Id --> maessage--> maessage id-->store message
    try {
      var timeSent = DateTime.now();
      UserModel? recieverUserData;
      var userDataMap =
          await firestore.collection('users').doc(recieverUserId).get();
      recieverUserData = UserModel.fromMap(userDataMap.data()!);
      var messageId = const Uuid().v1();
      _saveDataToContactsSubCollections(
          senderUser, recieverUserData, text, timeSent, recieverUserId);

      _saveMessageToMessageSubcollection(
        recieverUserId: recieverUserId,
        text: text,
        timeSent: timeSent,
        messageType: MessageEnum.text,
        messageId: messageId,
        username: senderUser.name,
        recieverUserName: recieverUserData.name,
        senderUsername: senderUser.name,
        messageReply: messageReply,
      );
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  Stream<List<Message>> getChatStream(String recieverUserId) {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(recieverUserId)
        .collection('messages')
        .orderBy('timeSent')
        .snapshots()
        .map((event) {
      List<Message> messages = [];
      for (var document in event.docs) {
        messages.add(Message.fromMap(document.data()));
      }
      return messages;
    });
  }

  void sendFileMessage(
      { required BuildContext context,
        required File file,
        required String recieverUserId,
        required UserModel senderUserData,
        required ProviderRef ref,
        required MessageEnum messageEnum,
        required MessageReply? messageReply,
        // required bool isGroupChat,
      }) async {
    try {
      var timeSent = DateTime.now();
      var messageId = const Uuid().v1();
      String imageUrl = await ref
          .read(commonFirebaseStorageRepositoryProvider)
          .storeFileToFirebase(
            'chat/${messageEnum.type}/${senderUserData.uid}/$recieverUserId/$messageId',
            file,
          );
      UserModel? receiverUserData;
      var userDataMap =
          await firestore.collection('users').doc(recieverUserId).get();
      receiverUserData = UserModel.fromMap(userDataMap.data()!);
      String contactMsg;
      switch (messageEnum) {
        case MessageEnum.image:
          contactMsg = '📸 Photo';
        case MessageEnum.video:
          contactMsg = '🎥 Video';
        case MessageEnum.audio:
          contactMsg = '🎵 Audio';
        case MessageEnum.gif:
          contactMsg = 'GIF';
        default:
          contactMsg = 'New Message';
      }
      _saveDataToContactsSubCollections(
        senderUserData,
        receiverUserData,
        contactMsg,
        timeSent,
        recieverUserId,
      );

      _saveMessageToMessageSubcollection(
        recieverUserId: recieverUserId,
        text: imageUrl,
        timeSent: timeSent,
        messageId: messageId,
        username: senderUserData.name,
        senderUsername: senderUserData.name,
        recieverUserName: receiverUserData.name,
        messageType: messageEnum,
        messageReply: messageReply,
      );
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  void sendGIFMessage({
    required BuildContext context,
    required String gifUrl,
    required String recieverUserId,
    required UserModel senderUser,
    required MessageReply? messageReply,
    // required bool isGroupChat,
  }) async {
    try {
      var timeSent = DateTime.now();
      UserModel?recieverUserData;

      // if (!isGroupChat) {
      //   var userDataMap =
      //   await firestore.collection('users').doc(recieverUserId).get();
      //   recieverUserData = UserModel.fromMap(userDataMap.data()!);
      // }

      var messageId = const Uuid().v1();

      _saveDataToContactsSubCollections(
        senderUser,
        recieverUserData!,
        'GIF',
        timeSent,
        recieverUserId,
        // isGroupChat,
      );

      _saveMessageToMessageSubcollection(
        recieverUserId: recieverUserId,
        text: gifUrl,
        timeSent: timeSent,
        messageType: MessageEnum.gif,
        messageId: messageId,
        username: senderUser.name,
        messageReply: messageReply,
        recieverUserName: recieverUserData.name,
        senderUsername: senderUser.name,
        // isGroupChat: isGroupChat,
      );
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

}
