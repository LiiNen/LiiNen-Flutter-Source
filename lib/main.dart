import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loginView.dart';

void main()=> runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginView(),
      //   home: MyNav(),
    );
  }
}
