import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clone_flutter/common/widgets/loader.dart';
import 'package:whatsapp_clone_flutter/features/chat/controller/chat_controller.dart';
import 'package:whatsapp_clone_flutter/models/message_model.dart';
import 'package:whatsapp_clone_flutter/features/chat/widgets/sender_message_cart.dart';
import 'my_message_card.dart';

class ChatList extends ConsumerStatefulWidget {
  final String recieverUserId;
  const ChatList({super.key, required this.recieverUserId});

  @override
  ConsumerState<ChatList> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
  final ScrollController messageController = ScrollController();

  @override
  void dispose() {
    // TODO: implement dispose
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Message>>(
        stream:
            ref.read(chatControllerProvider).chatStream(widget.recieverUserId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }
          SchedulerBinding.instance.addPostFrameCallback((_) {
            messageController
                .jumpTo(messageController.position.maxScrollExtent);
          });
          return ListView.builder(
              controller: messageController,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final messageData = snapshot.data![index];
                var timeSent = DateFormat('Hm').format(messageData.timeSent);
                if (messageData.senderId ==
                    FirebaseAuth.instance.currentUser!.uid) {
                  /// My message card
                  return MyMessageCard(
                    date: timeSent,
                    message: messageData.text,
                    type: messageData.type,
                  );
                }

                /// Sender message card
                return SenderMessageCart(
                  date: timeSent,
                  message: messageData.text,
                  type: messageData.type,
                );
              });
        });
  }
}
