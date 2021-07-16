import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'navView.dart';

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginView();
}
class _LoginView extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: Text('Login Page', style: TextStyle(fontWeight: FontWeight.bold))
            ),
            SignInButton(Buttons.Apple, onPressed: _loginSuccess),
            SignInButton(Buttons.Google, onPressed: _loginSuccess),
            SignInButton(Buttons.Facebook, onPressed: _loginSuccess),
          ]
        )
      )
    );
  }
  void _loginSuccess() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      pref.setBool('login', true);
    });
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavView()));
  }
}