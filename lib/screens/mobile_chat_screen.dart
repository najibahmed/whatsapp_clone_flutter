import 'package:flutter/material.dart';
import 'package:whatsapp_clone_flutter/common/utils/colors.dart';
import 'package:whatsapp_clone_flutter/info.dart';
import 'package:whatsapp_clone_flutter/widgets/chat_list.dart';

class MobileChatScreen extends StatefulWidget {
  const MobileChatScreen({super.key});

  @override
  State<MobileChatScreen> createState() => _MobileChatScreenState();
}

class _MobileChatScreenState extends State<MobileChatScreen> {
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
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(
             onPressed: (){
               Navigator.pop(context);
             },
            icon:Icon(Icons.arrow_back)),
        centerTitle: false,
        backgroundColor: appBarColor,
        title: Text(info[5]['name'].toString(),),
        actions: [
          IconButton(
              onPressed: () {},
              icon:
              const Icon(Icons.video_call_outlined, color: Colors.white)),
          IconButton(
              onPressed: () {},
              icon:
              const Icon(Icons.call_outlined, color: Colors.white)),
          IconButton(
              onPressed: () {},
              icon:
              const Icon(Icons.more_vert, color: Colors.white)),
        ],
      ),
      body:  Column(
        children: [
          ///Chat list
          Expanded(child:ChatList()),
          ///Text Input
          Container(
            height: MediaQuery.of(context).size.height * 0.08,
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: dividerColor)),
                color: chatBarMessage),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.emoji_emotions_outlined,
                        color: Colors.grey)),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 15),
                    child: TextField(
                      controller: chatController,
                      decoration: InputDecoration(
                        suffixIcon: Row(
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
    );
  }
}
