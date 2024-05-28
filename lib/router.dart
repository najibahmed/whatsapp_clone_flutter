import 'dart:js';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone_flutter/common/widgets/error.dart';
import 'package:whatsapp_clone_flutter/features/auth/screens/login_screen.dart';
import 'package:whatsapp_clone_flutter/features/auth/screens/otp_screen.dart';
import 'package:whatsapp_clone_flutter/features/auth/screens/user_information_screen.dart';

Route <dynamic> generateRoute(RouteSettings settings){
  switch(settings.name){
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (context)=>const LoginScreen());
    case OtpScreen.routeName:
      final verificationId = settings.arguments as String;
      return MaterialPageRoute(builder: (context)=> OtpScreen(verificationId: verificationId,));
    case UserInformationScreen.routeName:
      return MaterialPageRoute(builder: (context)=> UserInformationScreen());
    default:
      return MaterialPageRoute(builder: (context)=>const Scaffold(
        body: ErrorScreen(error: "This Page doesn't exist"),
      ));
  }
}