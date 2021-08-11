import 'package:flutter/material.dart';
import 'package:my_flutter_source/containerCollection.dart';
import 'package:my_flutter_source/functionCollection.dart';

import 'policyView.dart';

class LoginEmailView extends StatefulWidget {
  @override
  State<LoginEmailView> createState() => _LoginEmailView();
}
class _LoginEmailView extends State<LoginEmailView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LoginViewAppBar(),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 21),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.white,),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24),
                  Text('이메일 로그인',
                    style: textStyle(weight: 700, size: 20.0),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 24),
                  Text('이메일', style: textStyle(weight: 700, size: 14.0), textAlign: TextAlign.left,),
                  SizedBox(height: 8),
                  TextField(
                    controller: emailController,
                    autofocus: false,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 14.0),
                      border: OutlineInputBorder(),
                      hintText: '이메일을 입력해주세요',
                    ),
                    style: textStyle(weight: 600, size: 12.0),
                    onChanged: (value) {setState(() {});},
                  ),
                  SizedBox(height: 20),
                  Text('비밀번호', style: textStyle(weight: 700, size: 14.0), textAlign: TextAlign.left,),
                  SizedBox(height: 8),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    autofocus: false,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 14.0),
                      border: OutlineInputBorder(),
                      hintText: '비밀번호를 입력해주세요'
                    ),
                    style: textStyle(weight: 600, size: 12.0),
                    onChanged: (value) {setState(() {});},
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text('아이디/비밀번호 찾기', style: textStyle(weight: 600, size: 12.0), textAlign: TextAlign.right),
                  ),
                  SizedBox(height: 36),
                  Container(
                      height: 52,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(4)
                          ),
                          color: emailController.text != '' && passwordController.text != '' ? Color(0xff0958c5) : Color(0xffd1d5d9)
                      ),
                      child: Center(child: Text('로그인', style: textStyle(color: Colors.white, weight: 600, size: 16.0)))
                  ),
                ]
              ),
              Positioned(
                bottom: 36,
                child: Container(
                  width: MediaQuery.of(context).size.width - 42,
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
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _signUpBtnClick() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => PolicyView()));
  }
}
