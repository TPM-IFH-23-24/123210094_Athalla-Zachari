import 'package:flutter/material.dart';
import 'package:practice_quiz/utils/colors.dart';

import 'pages/home.dart';
import 'pages/login.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  await GetStorage.init('checkLogin');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final setLogin = GetStorage('setLogin');
    bool isLogged = setLogin.read('isLogged') ?? false;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLogged ? const HomeScreen() : const LoginPage(),
      theme: ThemeData(
        scaffoldBackgroundColor: mainBackgroundColor),
    );
  }
}