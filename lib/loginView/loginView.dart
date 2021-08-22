import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_flutter_source/constraintCollection.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../navView/navView.dart';
import 'loginEmailView.dart';
import 'package:my_flutter_source/main.dart';

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
              sizedBox(40),
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
              sizedBox(12),
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
              sizedBox(44),
              GestureDetector(
                onTap: _loginSuccess,
                child: SvgPicture.asset('asset/loginView/appleBtn.svg', width: 333 * responsiveScale, height: 52 * responsiveScale)
              ),
              sizedBox(8),
              GestureDetector(
                  onTap: _loginSuccess,
                  child: SvgPicture.asset('asset/loginView/kakaoBtn.svg', width: 333 * responsiveScale, height: 52 * responsiveScale)
              ),
              sizedBox(8),
              GestureDetector(
                  onTap: _loginEmail,
                  child: SvgPicture.asset('asset/loginView/emailBtn.svg', width: 333 * responsiveScale, height: 52 * responsiveScale)
              )
            ],
          )
        )
      )
    );

  }
  void _loginSuccess() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      // pref.setBool('login', true);
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
  MaskAppBar() : preferredSize = Size.fromHeight(384.0 * responsiveScale);
  @override
  final Size preferredSize;

  @override
  State<MaskAppBar> createState() => _MaskAppBar();
}
class _MaskAppBar extends State<MaskAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 384.0 * responsiveScale,
      elevation: 0,
      brightness: Brightness.light, // this makes status bar text color black
      backgroundColor: const Color(0xffedf2f8),
      title: Stack(
        children: [
          Positioned(
            top: 78,
            child: SvgPicture.asset('asset/loginView/messageImg.svg', width: 217, height: 92)
          ),
          Container(
            padding: EdgeInsets.only(top: 192 * responsiveScale),
            child: Center(
              child: Container(
                width: 165 * responsiveScale, height: 192 * responsiveScale,
                child: Image.asset('asset/loginView/bannerImg.png', fit:BoxFit.fill)
              ),
            )
          )
        ],
      )
    );
  }
}
