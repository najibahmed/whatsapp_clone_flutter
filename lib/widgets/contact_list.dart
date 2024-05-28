import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone_flutter/common/utils/colors.dart';
import 'package:whatsapp_clone_flutter/screens/mobile_chat_screen.dart';

import '../info.dart';

class ContactList extends StatelessWidget {
  const ContactList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: info.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MobileChatScreen()));
                },
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(info[index]['profilePic'].toString()),
                        radius: 30,
                      ),
                      trailing: Text(
                        info[index]['time'].toString(),
                        style:
                            const TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      title: Text(info[index]['name'].toString(),
                          style: const TextStyle(fontSize: 18)),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: Text(
                          info[index]['message'].toString(),
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                    const Divider(indent: 85, color: dividerColor)
                  ],
                ),
              );
            }));
  }
}
