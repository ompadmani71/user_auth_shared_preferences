import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_authentication_app/screens/home_screen.dart';
import 'package:user_authentication_app/screens/login_screen.dart';
import 'package:user_authentication_app/screens/sign_IN_screen.dart';

import 'global.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool? isLogin = prefs.getBool("isLogin") ?? false;
  bool? isRemember = prefs.getBool("isRemember") ?? false;
  runApp(
    MaterialApp(
      initialRoute: (isLogin == false)
          ? "user_details_screens"
          : (isRemember == false)
          ? "login_page"
          : "/",
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => const HomeScreen(),
        "login_page": (context) => const LoginScreen(),
        "user_details_screens": (context) => const SignINScreen(),
      },
    ),
  );
}
