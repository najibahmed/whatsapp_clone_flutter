import 'package:flutter/material.dart';
import 'package:whatsapp_clone_flutter/info.dart';
import 'package:whatsapp_clone_flutter/widgets/sender_message_cart.dart';

import 'my_message_card.dart';


class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context,index){
          if(messages[index]['isMe']==true){
            /// My message card
             return  MyMessageCard(date:messages[index]['time'].toString() , message: messages[index]['text'].toString(),);
          }
          /// Sender message card
         return SenderMessageCart(date:messages[index]['time'].toString() , message: messages[index]['text'].toString(),);
        }
    );
  }
}
