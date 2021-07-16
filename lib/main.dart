import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loginView.dart';
import 'navView.dart';

void main()=> runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainRouter(),
      //   home: NavView(),
    );
  }
}

class MainRouter extends StatefulWidget {
  @override
  State<MainRouter> createState() => _MainRouter();
}
class _MainRouter extends State<MainRouter> {
  bool? _loginState;

  @override
  initState() {
    super.initState();
    new Future.delayed(new Duration(seconds: 2), _checkLogin);
  }
  _checkLogin() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      _loginState = pref.getBool('login') ?? false;
      print(_loginState);
    });
  }

  @override
  Widget build(BuildContext context) {
    if(_loginState != null && _loginState!){
      return MaterialApp(
        home: NavView()
      );
    }
    else if (_loginState != null && !_loginState!) {
      return MaterialApp(
        home: LoginView()
      );
    }
    return Scaffold(
      body: Center(
        child: Text('메인 로딩 페이지...', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),)
      )
    );
  }
}