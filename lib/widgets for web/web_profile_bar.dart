import 'package:flutter/material.dart';
import 'package:whatsapp_clone_flutter/common/utils/colors.dart';

class WebProfileBar extends StatelessWidget {
  const WebProfileBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.077,
      width: MediaQuery.of(context).size.width*0.30,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(
            color: dividerColor
          )
        ),
        color: webAppBarColor
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage('https://uploads.dailydot.com/2018/10/olli-the-polite-cat.jpg?auto=compress%2Cformat&ixlib=php-3.3.0'),
          ),
          Spacer(),
          IconButton(
              onPressed: (){},
              icon:const  Icon(Icons.comment,color: Colors.grey,)),
          IconButton(
              onPressed: (){},
              icon:const  Icon(Icons.more_vert,color: Colors.grey,)),
        ],
      ),
    );
  }
}
