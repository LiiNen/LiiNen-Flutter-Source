import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'loginView/loginView.dart';
import 'navView/navView.dart';

void main()=> runApp(MyApp());

double responsiveScale = 1.0;

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
    });
  }

  @override
  Widget build(BuildContext context) {
    var a = MediaQuery.of(context).size.width / 375;
    var b = MediaQuery.of(context).size.height / 812;
    responsiveScale = a < b ? a : b;
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
        child: SvgPicture.asset(
          'asset/image/splashLogo.svg'
        )
      )
    );
  }
}