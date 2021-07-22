import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/animation.dart';

import 'navView/navView.dart';

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginView();
}
class _LoginView extends State<LoginView> with TickerProviderStateMixin{

  bool _loginVisible = false;
  bool _isInit = false;

  late final AnimationController _logoAnimationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
  late final Animation<Offset> _logoAnimation = Tween<Offset>(begin: Offset.zero, end: const Offset(0, -0.5)).animate(_logoAnimationController)
    ..addListener(() {
      new Future.delayed(Duration(seconds: 1), () => setState(() {
        _loginVisible = true;
        _isInit = true;
      }));
    });

  @override
  void initState() {
    super.initState();
    _logoAnimationController.forward();
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    super.dispose();
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
                child: Center(child: AnimatedContainer(
                  height: _isInit ? 140 : 180,
                  width: _isInit ? 140 : 180,
                  duration: Duration(seconds: 1),
                  child: FlutterLogo(),
                ))
              )
            ))),
            Center(
              child: AnimatedOpacity(
                opacity: _loginVisible ? 1 : 0,
                duration: Duration(milliseconds: 500),
                child: Padding(padding: EdgeInsets.only(top: 200), child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SignInButton(Buttons.Apple, onPressed: _loginSuccess),
                      SignInButton(Buttons.Google, onPressed: _loginSuccess),
                      SignInButton(Buttons.Facebook, onPressed: _loginSuccess),
                    ]
                ))
              ),
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

  void _loginApple() async {

  }
  void _loginGoogle() async {

  }
  void _loginFacebook() async {

  }
}