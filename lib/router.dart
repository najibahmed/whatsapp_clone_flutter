import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone_flutter/common/widgets/error.dart';
import 'package:whatsapp_clone_flutter/features/auth/screens/login_screen.dart';
import 'package:whatsapp_clone_flutter/features/auth/screens/otp_screen.dart';
import 'package:whatsapp_clone_flutter/features/auth/screens/user_information_screen.dart';
import 'package:whatsapp_clone_flutter/features/chat/screen/chat_screen_mobile.dart';
import 'package:whatsapp_clone_flutter/features/select_contact/screens/select_contact_screen.dart';
import 'package:whatsapp_clone_flutter/features/status/screen/confirm_status_screen.dart';
import 'package:whatsapp_clone_flutter/features/status/screen/status_screen.dart';
import 'package:whatsapp_clone_flutter/models/status_model.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case OtpScreen.routeName:
      final verificationId = settings.arguments as String;
      return MaterialPageRoute(
          builder: (context) => OtpScreen(
                verificationId: verificationId,
              ));
    case UserInformationScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const UserInformationScreen());
    case StatusScreen.routeName:
      final status = settings.arguments as Status;
      return MaterialPageRoute(
          builder: (context) => StatusScreen(
                status: status,
              ));
    case SelectContactScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const SelectContactScreen());
    case ConfirmStatusScreen.routeName:
      final file = settings.arguments as File;
      return MaterialPageRoute(
        builder: (context) => ConfirmStatusScreen(
          file: file,
        ),
      );
    case MobileChatScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final name = arguments['name'];
      final uid = arguments['uid'];
      return MaterialPageRoute(
          builder: (context) => MobileChatScreen(
                name: name,
                uid: uid,
              ));
    default:
      return MaterialPageRoute(
          builder: (context) => const Scaffold(
                body: ErrorScreen(error: "This Page doesn't exist"),
              ));
  }
}
