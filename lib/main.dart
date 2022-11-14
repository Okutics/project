import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/Controllers/home_controller.dart';
import 'package:project/Helper/colors.dart';
import 'package:project/Views/Auth/login_page.dart';
import 'package:project/Views/Home/home_app_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(HomeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('en', 'US'),
      theme: ThemeData(
        canvasColor: colors.white,
        cardColor: colors.white,
        dialogBackgroundColor: colors.white,
        iconTheme: Theme.of(context).iconTheme.copyWith(color: colors.primary),
        primarySwatch: colors.primaryApp,
        primaryColor: colors.lightWhite,
        brightness: Brightness.light,
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: colors.fontColor,
          ),
          headline2: TextStyle(
            fontSize: 20,
            color: colors.fontColor,
          ),
          headline3: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 18,
            color: colors.fontColor,
          ),
          headline4: TextStyle(
            fontSize: 16,
            color: colors.fontColor,
            fontWeight: FontWeight.w400,
          ),
          headline5: TextStyle(
            color: colors.fontColor,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          headline6: TextStyle(
            fontSize: 14,
            color: colors.fontColor,
            fontWeight: FontWeight.w400,
          ),
          subtitle1: TextStyle(
            fontSize: 12,
            color: colors.fontColor,
            fontWeight: FontWeight.bold,
          ),
          subtitle2: TextStyle(
            fontSize: 12,
            color: colors.fontColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      routes: {
        '/': (context) => const LoginPage(),
        'home': (context) => const HomeAppBar(),
      },
    );
  }
}
