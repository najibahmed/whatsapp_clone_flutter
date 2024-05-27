import 'package:flutter/material.dart';
import 'package:whatsapp_clone_flutter/constants/colors.dart';
import 'package:whatsapp_clone_flutter/resposive_ui.dart';
import 'package:whatsapp_clone_flutter/screens/mobile_screen_layout.dart';
import 'package:whatsapp_clone_flutter/screens/web_screen_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor
      ),
      home: const ResponsiveLayout(
        mobileScreenLayout: MobileScreenLayout(),
        webScreenLayout: WebScreenLayout(),
      )
    );
  }
}
