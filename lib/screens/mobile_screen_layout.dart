import 'package:flutter/material.dart';
import 'package:whatsapp_clone_flutter/common/utils/colors.dart';
import 'package:whatsapp_clone_flutter/widgets/contact_list.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
   ContactList()
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            backgroundColor: tabColor,
            onPressed:(){} ,
            child: Icon(Icons.add_comment,color:Colors.black ,),

          ),
          bottomNavigationBar: BottomNavigationBar(

            unselectedItemColor: Colors.grey,
            selectedItemColor: tabColor,
            elevation: 0,
            selectedLabelStyle: TextStyle(
              color: tabColor,
                fontWeight: FontWeight.bold
            ),
            unselectedLabelStyle: TextStyle(
                color: Colors.grey,
            ),
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_outlined),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.update_outlined),
                label: 'Updates',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.call_outlined),
                label: 'Calls',
              ),
            ],
          ),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: appBarColor,
            title: const Text('WhatsApp',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            centerTitle: false,
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.grey,
                  )),
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
            // bottom: const TabBar(
            //   indicatorColor: tabColor,
            //   indicatorWeight: 4,
            //   labelColor: tabColor,
            //   unselectedLabelColor: Colors.grey,
            //   labelStyle: TextStyle(
            //     fontWeight: FontWeight.bold
            //   ),
            //   tabs: [
            //     Tab(
            //       text: "CHATS",
            //     ),
            //     Tab(
            //       text: "STATUS",
            //     ),
            //     Tab(
            //       text: "CALLS",
            //     ),
            //   ],
            // ),
          ),
          body: const ContactList(),
        ));
  }
}
