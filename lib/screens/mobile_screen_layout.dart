import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/common/utils/colors.dart';
import 'package:whatsapp_clone_flutter/common/utils/utils.dart';
import 'package:whatsapp_clone_flutter/features/auth/controller/auth_controller.dart';
import 'package:whatsapp_clone_flutter/features/select_contact/screens/select_contact_screen.dart';
import 'package:whatsapp_clone_flutter/features/chat/widgets/contact_list.dart';
import 'package:whatsapp_clone_flutter/features/status/screen/confirm_status_screen.dart';

import '../features/status/screen/status_contact_screen.dart';

class MobileScreenLayout extends ConsumerStatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  ConsumerState<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends ConsumerState<MobileScreenLayout>
    with WidgetsBindingObserver {
  int _currentIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        ref.read(authControllerProvider).setUserState(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        ref.read(authControllerProvider).setUserState(false);
        break;
    }
  }

  final List<Widget> _screens = [
    ContactList(),
    StatusContactsScreen(),
    FlutterLogo()
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            backgroundColor: tabColor,
            onPressed: () async {
              if (_currentIndex == 0) {
                Navigator.pushNamed(context, SelectContactScreen.routeName);
              } else {
                File? pickedImage = await pickImageFromGallery(context);
                if (pickedImage != null) {
                  Navigator.pushNamed(context, ConfirmStatusScreen.routeName,arguments: pickedImage);
                }
              }
            },
            child: Icon(
              Icons.add_comment,
              color: Colors.black,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.grey,
            selectedItemColor: tabColor,
            elevation: 0,
            selectedLabelStyle:
                TextStyle(color: tabColor, fontWeight: FontWeight.bold),
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
              PopupMenuButton(
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.grey,
                ),
                itemBuilder: (context) => [
                  // PopupMenuItem(
                  //   child: const Text(
                  //     'Create Group',
                  //   ),
                  //   onTap: () => Future(
                  //         // () => Navigator.pushNamed(
                  //         // context, CreateGroupScreen.routeName),
                  //   ),
                  // )
                ],
              ),
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
          body: _screens[_currentIndex],
        ));
  }
}
