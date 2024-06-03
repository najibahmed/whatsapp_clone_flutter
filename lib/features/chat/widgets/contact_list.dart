
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clone_flutter/common/utils/colors.dart';
import 'package:whatsapp_clone_flutter/common/widgets/loader.dart';
import 'package:whatsapp_clone_flutter/features/chat/controller/chat_controller.dart';
import 'package:whatsapp_clone_flutter/models/chat_contact.dart';


import '../../select_contact/screens/select_contact_screen.dart';
import '../screen/chat_screen_mobile.dart';
import '../../../info.dart';

class ContactList extends ConsumerWidget {
  const ContactList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: StreamBuilder<List<ChatContact>>(
            stream: ref.watch(chatControllerProvider).chatContacts(),
            builder: (context, snapshot) {
              if(snapshot.data == null){
                return ListTile(
                  onTap: (){
                    Navigator.pushNamed(context, SelectContactScreen.routeName);
                  },
                  leading: Icon(Icons.chat_sharp),
                  title: Text('Tap to start a Conversation'),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loader();
              }
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var chatContactData = snapshot.data![index];
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context,
                            MobileChatScreen.routeName,
                            arguments: {
                          'name': chatContactData.name,
                          'uid': chatContactData.contactId
                            },
                        );
                        
                      },
                      child: Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(chatContactData.profilePic),
                              radius: 30,
                            ),
                            trailing: Text(
                              DateFormat.Hm().format(chatContactData.timeSent),
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.grey),
                            ),
                            title: Text(chatContactData.name,
                                style: const TextStyle(fontSize: 18)),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 6.0),
                              child: Text(
                                chatContactData.lastMessage,
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                          const Divider(indent: 85, color: dividerColor)
                        ],
                      ),
                    );
                  });
            }));
  }
}
