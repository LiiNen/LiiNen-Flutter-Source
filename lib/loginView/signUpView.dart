import 'package:flutter/material.dart';
import 'package:my_flutter_source/containerCollection.dart';
import 'package:my_flutter_source/functionCollection.dart';
import 'package:my_flutter_source/loginView/profileSetupView.dart';
import 'package:my_flutter_source/main.dart';

class SignUpView extends StatefulWidget {
  @override
  State<SignUpView> createState() => _SignUpView();
}
class _SignUpView extends State<SignUpView> {
  bool pwFirstConfirm = false;
  bool pwSecondConfirm = false;

  final emailController = TextEditingController();
  final pwFirstController = TextEditingController();
  final pwSecondController = TextEditingController();
  //TODO: 오류 색상 변경
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LoginViewAppBar(),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 21 * responsiveScale),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24 * responsiveScale),
              Text('이메일로 회원가입', style: textStyle(weight: 700, size: 20.0), textAlign: TextAlign.left,),
              SizedBox(height: 24 * responsiveScale),
              Text('이메일', style: textStyle(weight: 700, size: 14.0), textAlign: TextAlign.left),
              SizedBox(height: 8 * responsiveScale),
              TextField(
                controller: emailController,
                autofocus: false,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 14.0),
                    border: OutlineInputBorder(),
                    hintText: '이메일을 입력해주세요'
                ),
                style: textStyle(weight: 600, size: 12.0),
                onChanged: (value) {setState(() {});},
              ),
              SizedBox(height: 20 * responsiveScale),
              Text('비밀번호', style: textStyle(weight: 700, size: 14.0), textAlign: TextAlign.left,),
              SizedBox(height: 8 * responsiveScale),
              TextField(
                controller: pwFirstController,
                obscureText: true,
                autofocus: false,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 14.0 * responsiveScale),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: pwFirstConfirm ? Color(0xff0958c5) : Color(0xffd93826), width: 1)
                  ),
                  hintText: '비밀번호를 입력해주세요'
                ),
                style: textStyle(weight: 600, size: 12.0),
                onChanged: (value) {setState(() {
                  pwSecondConfirm = (pwFirstController.text == pwSecondController.text ? true : false);
                });},
              ),
              SizedBox(height: 4 * responsiveScale),
              Text('영문, 숫자를 포함한 8자 이상의 비밀번호를 입력해주세요.',
                style: textStyle(color: Color(0xff636c73), weight: 400, size: 12.0),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 24 * responsiveScale),
              Text('비밀번호 확인', style: textStyle(weight: 700, size: 14.0), textAlign: TextAlign.left,),
              SizedBox(height: 8 * responsiveScale),
              TextField(
                controller: pwSecondController,
                obscureText: true,
                autofocus: false,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 14.0 * responsiveScale),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: pwSecondConfirm ? Color(0xff0958c5) : Color(0xffd93826), width: 1),
                    ),
                    hintText: '비밀번호를 한번 더 입력해주세요'
                ),
                style: textStyle(weight: 600, size: 12.0),
                onChanged: (value) {setState(() {
                  pwSecondConfirm = (pwFirstController.text == pwSecondController.text ? true : false);
                });},
              ),
              SizedBox(height: 36 * responsiveScale),
              GestureDetector(
                onTap: _nextStep,
                child: Container(
                  height: 52 * responsiveScale,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4)
                    ),
                    color: emailController.text != '' && pwSecondConfirm ? Color(0xff0958c5) : Color(0xffd1d5d9)
                  ),
                  child: Center(child: Text('회원가입', style: textStyle(color: Colors.white, weight: 600, size: 16.0)))
                )
              ),
            ]
          )
        )
      )
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    pwFirstController.dispose();
    pwSecondController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if(emailController.text != '' && pwSecondConfirm) Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileSetupView()));
  }
}