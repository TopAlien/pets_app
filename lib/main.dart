/*
 * @Author: 大能猫🐱
 * @Description: 哇咔咔
 * @Date: 2021-08-11 16:30:52
 */
import 'package:flutter/material.dart';
import 'package:pets_app/config/app_config.dart';
import 'package:pets_app/page/tab/tab_page.dart';

void main() {
  runApp(InitApp());
}

class InitApp extends StatelessWidget {
  const InitApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppConfig.primaryColor,
        appBarTheme: AppBarTheme(color: Colors.white),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      home: BottomTabPage(),
      title: "宠它",
    );
  }
}
