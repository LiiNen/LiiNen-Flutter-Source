import 'package:flutter/material.dart';
import 'package:my_flutter_source/containerCollection.dart';
import 'package:my_flutter_source/functionCollection.dart';
import 'package:my_flutter_source/main.dart';
import 'package:my_flutter_source/navView/navView.dart';

import 'policyView.dart';

class LoginEmailView extends StatefulWidget {
  @override
  State<LoginEmailView> createState() => _LoginEmailView();
}
class _LoginEmailView extends State<LoginEmailView> {
  var _scrollController = ScrollController();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var emailFocus = FocusNode();
  var passwordFocus = FocusNode();

  //TODO: 스크롤 버그 존재
  @override
  void initState() {
    emailFocus.addListener(() {
      scrollOnFocus(_scrollController, 96 * responsiveScale);
    });
    passwordFocus.addListener(() {
      scrollOnFocus(_scrollController, 211 * responsiveScale);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: LoginViewAppBar(),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 21 * responsiveScale),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.white,),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24 * responsiveScale),
                    Text('이메일 로그인',
                      style: textStyle(weight: 700, size: 20.0),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 24 * responsiveScale),
                    Text('이메일', style: textStyle(weight: 700, size: 14.0), textAlign: TextAlign.left,),
                    SizedBox(height: 8 * responsiveScale),
                    TextField(
                      controller: emailController,
                      focusNode: emailFocus,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 14.0 * responsiveScale),
                        enabledBorder: enabledBorderDefault(),
                        focusedBorder: focusedBorderDefault(),
                        hintText: '이메일을 입력해주세요',
                      ),
                      style: textStyle(weight: 600, size: 12.0),
                      onChanged: (value) {setState(() {});},
                      textInputAction: TextInputAction.next,
                      onSubmitted: (value) => {passwordFocus.requestFocus()},
                    ),
                    SizedBox(height: 20),
                    Text('비밀번호', style: textStyle(weight: 700, size: 14.0), textAlign: TextAlign.left,),
                    SizedBox(height: 8),
                    TextField(
                      controller: passwordController,
                      focusNode: passwordFocus,
                      obscureText: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 14.0 * responsiveScale),
                        enabledBorder: enabledBorderDefault(),
                        focusedBorder: focusedBorderDefault(),
                        hintText: '비밀번호를 입력해주세요'
                      ),
                      style: textStyle(weight: 600, size: 12.0),
                      onChanged: (value) {setState(() {});},
                      textInputAction: TextInputAction.done,
                      onSubmitted: (value) => {_loginAction(emailController.text, value)},
                    ),
                    SizedBox(height: 20 * responsiveScale),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text('아이디/비밀번호 찾기', style: textStyle(weight: 600, size: 12.0), textAlign: TextAlign.right),
                    ),
                    SizedBox(height: 36 * responsiveScale),
                    GestureDetector(
                      onTap: () => {_loginAction(emailController.text, passwordController.text)},
                      child: Container(
                        height: 52 * responsiveScale,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4)
                          ),
                          color: emailController.text != '' && passwordController.text != '' ? Color(0xff0958c5) : Color(0xffd1d5d9)
                        ),
                        child: Center(child: Text('로그인', style: textStyle(color: Colors.white, weight: 600, size: 16.0)))
                      ),
                    ),
                    SizedBox(height: 288 * responsiveScale),
                  ]
                ),
                Positioned(
                  bottom: 36 * responsiveScale,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 42 * responsiveScale,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('아직 계정이 없으신가요? ', style: textStyle(weight: 400, size: 16.0)),
                          GestureDetector(
                            child: Text('회원가입', style: textStyle(weight: 600, size: 16.0)),
                            onTap: _signUpBtnClick,
                          )
                        ]
                      )
                    )
                  )
                )
              ]
            )
          )
        )
      )
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  //TODO : login implements
  void _loginAction(email, password) {
    print(email);
    print(password);
    Navigator.push(context, MaterialPageRoute(builder: (context) => NavView()));
  }

  void _signUpBtnClick() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => PolicyView()));
  }
}
