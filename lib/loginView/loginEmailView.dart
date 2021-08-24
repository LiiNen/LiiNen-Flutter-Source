import 'package:flutter/material.dart';
import 'package:my_flutter_source/containerCollection.dart';
import 'package:my_flutter_source/functionCollection.dart';
import 'package:my_flutter_source/main.dart';
import 'package:my_flutter_source/navView/navView.dart';
import 'package:my_flutter_source/constraintCollection.dart';

import 'loginWidgets.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        appBar: LoginViewAppBar(),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 21 * responsiveScale),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 116,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sizedBox(24),
                    loginTitle('이메일 로그인',),
                    sizedBox(24),
                    loginSubtitle('이메일'),
                    sizedBox(8),
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
                    sizedBox(20),
                    loginSubtitle('비밀번호'),
                    sizedBox(8),
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
                      onSubmitted: (value) => {_loginAction()},
                    ),
                    sizedBox(20),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text('아이디/비밀번호 찾기', style: textStyle(weight: 600, size: 12.0), textAlign: TextAlign.right),
                    ),
                    sizedBox(36),
                    confirmButton(title: '로그인', confirmAction: _loginAction, condition: emailController.text != '' && passwordController.text != ''),
                  ]
                ),
                Column(
                  children: [
                    Container(
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
                    ),
                    sizedBox(36),
                  ],
                )
              ]
            )
          )
        ),
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
  void _loginAction() {
    navigatorPush(context: context, widget: NavView());
  }

  void _signUpBtnClick() {
    navigatorPush(context: context, widget: PolicyView(), replacement: true);
  }
}
