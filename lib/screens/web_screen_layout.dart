import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:whatsapp_clone_flutter/features/chat/widgets/contact_list.dart';

import '../common/utils/colors.dart';
import '../features/chat/widgets/chat_list.dart';
import '../widgets for web/web_chat_app_bar.dart';
import '../widgets for web/web_profile_bar.dart';
import '../widgets for web/web_search_bar.dart';


class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({super.key});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  bool _isTextFieldEmpty = true;
  TextEditingController chatController = TextEditingController();
  @override
  void initState() {
    chatController.addListener(_handleTextFieldChange);
    super.initState();
  }

  void _handleTextFieldChange() {
    setState(() {
      _isTextFieldEmpty = chatController.text.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                /// Wev profile bar
                WebProfileBar(),

                /// Web search
                WebSearchBar(),
                ContactsList(),

                /// Web Screen
              ],
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * .70,
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(color: dividerColor),
            ),
            image: DecorationImage(
              image: AssetImage(
                "assets/backgroundImage.png",
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              /// Chat App Bar
              WebChatAppBar(),

              /// chat list
              // Expanded(child: ChatList(recieverUserId: '',)),

              /// Message input box
              Container(
                height: MediaQuery.of(context).size.height * 0.08,
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: dividerColor)),
                    color: chatBarMessage),

                child: Row(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.attach_file_outlined,
                                color: Colors.grey)),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.camera_alt_outlined,
                                color: Colors.grey)),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 15),
                        child: TextField(
                          controller: chatController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.emoji_emotions_outlined,
                                    color: Colors.grey)),
                            filled: true,
                            fillColor: searchBarColor,
                            hintText: 'Type a message',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            contentPadding: const EdgeInsets.only(left: 20),
                          ),
                        ),
                      ),
                    ),
                    _isTextFieldEmpty
                        ? IconButton(
                            onPressed: () {},
                            icon:
                                 Icon(Icons.mic_none, color:Colors.grey))
                        : IconButton(
                            onPressed: () {},
                            icon:
                                const Icon(Icons.send, color: messageColor)),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    ));
  }
}
