import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/animation.dart';

import '../navView/navView.dart';
import 'loginEmailView.dart';

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginView();
}
class _LoginView extends State<LoginView> with TickerProviderStateMixin{

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MaskAppBar(),
      body: Container(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 40),
              Text(
                "환영합니다 🙌",
                style: const TextStyle(
                    color:  const Color(0xff000000),
                    fontWeight: FontWeight.w700,
                    fontFamily: "AppleSDGothicNeo",
                    fontStyle:  FontStyle.normal,
                    fontSize: 28.0
                )
              ),
              SizedBox(height: 12),
              Text(
                "이건모임에서 목표를 달성해보세요!",
                style: const TextStyle(
                    color:  const Color(0xff4a4a4a),
                    fontWeight: FontWeight.w400,
                    fontFamily: "AppleSDGothicNeo",
                    fontStyle:  FontStyle.normal,
                    fontSize: 14.0
                ),
              ),
              SizedBox(height: 44),
              SignInButton(Buttons.Apple, onPressed: _loginSuccess),
              SignInButton(Buttons.Google, onPressed: _loginSuccess),
              SignInButton(Buttons.Facebook, onPressed: _loginEmail),
            ],
          )
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

  void _loginEmail() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginEmailView()));
  }

  void _loginApple() async {

  }
  void _loginGoogle() async {

  }
  void _loginFacebook() async {

  }
}

class MaskAppBar extends StatefulWidget implements PreferredSizeWidget {
  MaskAppBar() : preferredSize = Size.fromHeight(384.0);
  @override
  final Size preferredSize;

  @override
  State<MaskAppBar> createState() => _MaskAppBar();
}
class _MaskAppBar extends State<MaskAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 384.0,
      elevation: 0,
      brightness: Brightness.light, // this makes status bar text color black
      backgroundColor: const Color(0xffedf2f8),
      title: Stack(
        children: [
          Positioned(
            top: 78,
            child: SvgPicture.asset('asset/image/messageImg.svg', width: 217, height: 92)
          ),
          Container(
            padding: EdgeInsets.only(top: 192),
            child: Center(
              child: Container(
                width: 165, height: 192,
                child: Image.asset('asset/image/bannerImg.png', fit:BoxFit.fill)
              ),
            )
          )
        ],
      )
    );
  }
}
