import 'package:flutter/material.dart';
import 'package:new_project/theme_consts.dart';
import 'login_page.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final navigatorkey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorkey,
        debugShowCheckedModeBanner: false,
        title: "Let's",
        theme: ThemeData(
          inputDecorationTheme: ThemeTextField(),
          textTheme: const TextTheme(
            headline1: TextStyle(color: ThemeColors.mainTextColor),
          ),
          cardTheme: CardTheme(
              color: ThemeColors.mainThemeColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40))),
          iconTheme: const IconThemeData(color: ThemeColors.mainTextColor),
          drawerTheme: const DrawerThemeData(
              backgroundColor: ThemeColors.mainThemeColor, width: 300),
          appBarTheme: const AppBarTheme(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(40),
            )),
            toolbarHeight: 100,
            color: ThemeColors.mainThemeColor,
          ),
          primarySwatch: Colors.blue,
        ),
        home: const LoginPage());
  }
}

Center createCircleIndicator() => const Center(
    child: CircularProgressIndicator(color: ThemeColors.mainThemeColor));
