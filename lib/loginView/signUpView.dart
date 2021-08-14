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
  bool emailConfirm = false;
  bool pwFirstConfirm = false;
  bool pwSecondConfirm = false;

  final emailController = TextEditingController();
  final pwFirstController = TextEditingController();
  final pwSecondController = TextEditingController();

  var emailFocus = FocusNode();
  var pwFirstFocus = FocusNode();
  var pwSecondFocus = FocusNode();

  //TODO: 오류 색상 변경
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: LoginViewAppBar(),
      body: SingleChildScrollView(child: GestureDetector(
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
                focusNode: emailFocus,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 14.0 * responsiveScale),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: BorderSide(color: Color(0xffe4e4e4), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: BorderSide(color: emailConfirm || emailController.text == '' ? Color(0xff0958c5) : Color(0xffd93826), width: 1),
                    ),
                    hintText: '이메일을 입력해주세요'
                ),
                style: textStyle(weight: 600, size: 12.0),
                onChanged: (value) {setState(() {
                  emailConfirm = emailRegexCheck(emailController.text);
                });},
                textInputAction: TextInputAction.next,
                onSubmitted: (value) => {pwFirstFocus.requestFocus()},
              ),
              SizedBox(height: 20 * responsiveScale),
              Text('비밀번호', style: textStyle(weight: 700, size: 14.0), textAlign: TextAlign.left,),
              SizedBox(height: 8 * responsiveScale),
              TextField(
                controller: pwFirstController,
                obscureText: true,
                focusNode: pwFirstFocus,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 14.0 * responsiveScale),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                    borderSide: BorderSide(color: pwFirstConfirm || pwFirstController.text == '' ? Color(0xffe4e4e4) : Color(0xffd93826), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                    borderSide: BorderSide(color: pwFirstConfirm || pwFirstController.text == '' ? Color(0xff0958c5) : Color(0xffd93826), width: 1),
                  ),
                  hintText: '비밀번호를 입력해주세요'
                ),
                style: textStyle(weight: 600, size: 12.0),
                onChanged: (value) {setState(() {
                  pwFirstConfirm = passwordRegexCheck(pwFirstController.text);
                  pwSecondConfirm = (pwFirstController.text == pwSecondController.text ? true : false);
                });},
                textInputAction: TextInputAction.next,
                onSubmitted: (value) => {pwSecondFocus.requestFocus()},
              ),
              SizedBox(height: 4 * responsiveScale),
              (pwFirstController.text == ''  ?
                Text('영문, 숫자를 포함한 8자 이상의 비밀번호를 입력해주세요.',
                  style: textStyle(color: Color(0xff636c73), weight: 400, size: 12.0),
                  textAlign: TextAlign.left,
                ) : ( !pwFirstConfirm ?
                Text('비밀번호는 영문, 숫자를 포함하여 8자 이상이어야 합니다.',
                  style: textStyle(color: Color(0xffd93826), weight: 400, size: 12.0),
                  textAlign: TextAlign.left,
                ) :
                Text('적합한 비밀번호 입니다.',
                  style: textStyle(color: Colors.lightGreen, weight: 400, size: 12.0),
                  textAlign: TextAlign.left,
                ))
              ),
              SizedBox(height: 24 * responsiveScale),
              Text('비밀번호 확인', style: textStyle(weight: 700, size: 14.0), textAlign: TextAlign.left,),
              SizedBox(height: 8 * responsiveScale),
              TextField(
                controller: pwSecondController,
                obscureText: true,
                focusNode: pwSecondFocus,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 14.0 * responsiveScale),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                    borderSide: BorderSide(color: pwSecondConfirm || pwSecondController.text == '' ? Color(0xffe4e4e4) : Color(0xffd93826), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                    borderSide: BorderSide(color: pwSecondConfirm || pwSecondController.text == '' ? Color(0xff0958c5) : Color(0xffd93826), width: 1),
                  ),
                  hintText: '비밀번호를 한번 더 입력해주세요'
                ),
                style: textStyle(weight: 600, size: 12.0),
                onChanged: (value) {setState(() {
                  pwSecondConfirm = (pwFirstController.text == pwSecondController.text ? true : false);
                });},
                onSubmitted: (value) => {_nextStep()},
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
                    color: emailConfirm && pwFirstConfirm && pwSecondConfirm ? Color(0xff0958c5) : Color(0xffd1d5d9)
                  ),
                  child: Center(child: Text('회원가입', style: textStyle(color: Colors.white, weight: 600, size: 16.0)))
                )
              ),
            ]
          )
        )
      ))
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    pwFirstController.dispose();
    pwSecondController.dispose();
    emailFocus.dispose();
    pwFirstFocus.dispose();
    pwSecondController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if(emailController.text != '' && pwSecondConfirm) Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileSetupView()));
  }
}