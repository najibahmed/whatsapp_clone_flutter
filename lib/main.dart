import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/common/utils/colors.dart';
import 'package:whatsapp_clone_flutter/features/auth/controller/auth_controller.dart';
import 'package:whatsapp_clone_flutter/firebase_options.dart';
import 'package:whatsapp_clone_flutter/router.dart';
import 'package:whatsapp_clone_flutter/screens/mobile_screen_layout.dart';
import 'common/widgets/error.dart';
import 'common/widgets/loader.dart';
import 'landing/screens/landing_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Whatsapp UI',
        theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: backgroundColor,
            appBarTheme: const AppBarTheme(color: appBarColor)),
        onGenerateRoute: (settings) => generateRoute(settings),
        home: ref.watch(userDataAuthProvider).when(
          data: (user) {
            if (user == null) {
            return const MobileScreenLayout();
            }
              return const LandingScreen();
          },
          error: (err, trace) {
            return ErrorScreen(
              error: err.toString(),
            );
          },
          loading: () => const Loader(),
        ),
        // home: const LandingScreen()
        // // home: const ResponsiveLayout(
        // //   mobileScreenLayout: MobileScreenLayout(),
        // //   webScreenLayout: WebScreenLayout(),
        // // )
        );
  }
}
