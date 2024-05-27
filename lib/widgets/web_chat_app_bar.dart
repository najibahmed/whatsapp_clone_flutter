import 'package:flutter/material.dart';
import 'package:whatsapp_clone_flutter/constants/colors.dart';
import 'package:whatsapp_clone_flutter/info.dart';


class WebChatAppBar extends StatelessWidget {
  const WebChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width*.70,
      height: MediaQuery.of(context).size.height*.077,
      padding: const EdgeInsets.all(10),
      color: webAppBarColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundImage:NetworkImage('https://uploads.dailydot.com/2018/10/olli-the-polite-cat.jpg?auto=compress%2Cformat&ixlib=php-3.3.0'),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.01,
              ),
              Text(info[0]['name'].toString(),style: TextStyle(fontSize: 18),)
            ],
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.grey,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
