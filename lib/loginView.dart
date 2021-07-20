import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/animation.dart';

import 'navView.dart';

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginView();
}
class _LoginView extends State<LoginView> with TickerProviderStateMixin{

  late final AnimationController _logoAnimationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
  late final Animation<Offset> _logoAnimation = Tween<Offset>(begin: Offset.zero, end: const Offset(0, -0.5)).animate(_logoAnimationController);

  @override
  void initState() {
    super.initState();
    _logoAnimationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _logoAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Center(child: (Container(width: MediaQuery.of(context).size.width, height: 200,
              child: SlideTransition(
                position: _logoAnimation,
                child: Center(child: Text('메인 로딩 페이지...', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),))
              )
            ))),
            Center(
              child: Padding(padding: EdgeInsets.only(top: 200), child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SignInButton(Buttons.Apple, onPressed: _loginSuccess),
                    SignInButton(Buttons.Google, onPressed: _loginSuccess),
                    SignInButton(Buttons.Facebook, onPressed: _loginSuccess),
                  ]
              ))
            )
          ],
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