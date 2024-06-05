
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/common/provider/message_reply_provider.dart';

import 'display_text_image_gif.dart';

class MessageReplyPreview extends ConsumerWidget {

  const MessageReplyPreview({super.key});

  void cancelReply(WidgetRef ref){
    ref.read(messageReplyProvider.notifier).update((state) =>null );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final  messageReply = ref.watch(messageReplyProvider);
    return  Container(
      width: 350,
      padding: const EdgeInsets.all(8) ,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  messageReply!.isMe ? 'Me' : 'Opposite',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GestureDetector(
                child: const Icon(
                  Icons.close,
                  size: 16,
                ),
                onTap: () => cancelReply(ref),
              ),
            ],
          ),
          const SizedBox(height: 8),
          DisplayTextImageGIF(
            message: messageReply.message,
            type: messageReply.messageEnum,
          ),
        ],
      ),
    );
  }
}
