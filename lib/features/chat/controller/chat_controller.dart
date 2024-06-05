import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/common/provider/message_reply_provider.dart';
import 'package:whatsapp_clone_flutter/features/auth/controller/auth_controller.dart';
import 'package:whatsapp_clone_flutter/features/chat/repository/chat_repository.dart';
import '../../../common/enums/message_enum.dart';
import '../../../models/chat_contact.dart';
import '../../../models/message_model.dart';

final chatControllerProvider = Provider((ref) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  return ChatController(chatRepository: chatRepository, ref: ref);
});

class ChatController {
  final ChatRepository chatRepository;
  final ProviderRef ref;

  ChatController({required this.chatRepository, required this.ref});

  Stream<List<ChatContact>> chatContacts() {
    return chatRepository.getChatContacts();
  }

  Stream<List<Message>> chatStream(String recieverUserId) {
    return chatRepository.getChatStream(recieverUserId);
  }

  void sendTextMessage(
    BuildContext context,
    String text,
    String recieverUserId,
  ) {
    final messageReply = ref.read(messageReplyProvider);
    ref.read(userDataAuthProvider).whenData(
          (value) => chatRepository.sendTextMessage(
              context: context,
              text: text,
              recieverUserId: recieverUserId,
              senderUser: value!,
              messageReply: messageReply!,),
        );
  }

  void sendFileMessage(
      BuildContext context,
      File file,
      String recieverUserId,
      MessageEnum messageEnum,
      ) {
    final messageReply = ref.read(messageReplyProvider);
    ref.read(userDataAuthProvider).whenData(
          (value) => chatRepository.sendFileMessage(
          context: context,
          recieverUserId: recieverUserId,
          senderUserData: value!,
          file: file,
          ref: ref,
          messageEnum: messageEnum,
          messageReply: messageReply!,),
    );
  }

  void sendGIFMessage(
      BuildContext context,
      String gifUrl,
      String recieverUserId,
      // bool isGroupChat,
      ) {
    final messageReply = ref.read(messageReplyProvider);
    int gifUrlPartIndex = gifUrl.lastIndexOf('-') + 1;
    String gifUrlPart = gifUrl.substring(gifUrlPartIndex);
    String newgifUrl = 'https://i.giphy.com/media/$gifUrlPart/200.gif';

    ref.read(userDataAuthProvider).whenData(
          (value) => chatRepository.sendGIFMessage(
        context: context,
        gifUrl: newgifUrl,
        recieverUserId: recieverUserId,
        senderUser: value!,
        messageReply: messageReply,
        // isGroupChat: isGroupChat,
      ),
    );
    // ref.read(messageReplyProvider.state).update((state) => null);
  }

}
