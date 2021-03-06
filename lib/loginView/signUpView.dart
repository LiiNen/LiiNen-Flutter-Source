import 'package:flutter/material.dart';
import 'package:my_flutter_source/containerCollection.dart';
import 'package:my_flutter_source/functionCollection.dart';
import 'package:my_flutter_source/loginView/phoneAuthView.dart';
import 'package:my_flutter_source/loginView/profileSetupView.dart';
import 'package:my_flutter_source/main.dart';
import 'package:my_flutter_source/constraintCollection.dart';

import 'loginWidgets.dart';

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        appBar: LoginViewAppBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 21 * responsiveScale),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizedBox(24),
                loginTitle('이메일로 회원가입'),
                sizedBox(24),
                loginSubtitle('이메일'),
                sizedBox(8),
                TextField(
                  controller: emailController,
                  focusNode: emailFocus,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 14.0 * responsiveScale),
                    enabledBorder: enabledBorderDefault(),
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
                sizedBox(20),
                loginSubtitle('비밀번호'),
                sizedBox(8),
                TextField(
                  controller: pwFirstController,
                  obscureText: true,
                  focusNode: pwFirstFocus,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 14.0 * responsiveScale),
                    enabledBorder: pwFirstConfirm || pwFirstController.text == '' ? enabledBorderDefault() : inputBorderWarning(),
                    focusedBorder: pwFirstConfirm || pwFirstController.text == '' ? focusedBorderDefault() : inputBorderWarning(),
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
                sizedBox(4),
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
                sizedBox(24),
                loginSubtitle('비밀번호 확인'),
                sizedBox(8),
                TextField(
                  controller: pwSecondController,
                  obscureText: true,
                  focusNode: pwSecondFocus,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 14.0 * responsiveScale),
                    enabledBorder: pwSecondConfirm || pwSecondController.text == '' ? enabledBorderDefault() : inputBorderWarning(),
                    focusedBorder: pwSecondConfirm || pwSecondController.text == '' ? focusedBorderDefault() : inputBorderWarning(),
                    hintText: '비밀번호를 한번 더 입력해주세요'
                  ),
                  style: textStyle(weight: 600, size: 12.0),
                  onChanged: (value) {setState(() {
                    pwSecondConfirm = (pwFirstController.text == pwSecondController.text ? true : false);
                  });},
                  onSubmitted: (value) => {_nextStep()},
                ),
                sizedBox(4),
                (pwSecondController.text == '' ? Text('', style: textStyle(color: Colors.white, weight: 400, size: 12.0),) : (pwSecondConfirm  ?
                  Text('비밀번호가 일치합니다.',
                    style: textStyle(color: Colors.lightGreen, weight: 400, size: 12.0),
                    textAlign: TextAlign.left,
                  ) :
                  Text('비밀번호가 일치하지 않습니다.',
                    style: textStyle(color: Color(0xffd93826), weight: 400, size: 12.0),
                    textAlign: TextAlign.left,
                  )
                )),
                sizedBox(36),
                confirmButton(title: '회원가입', confirmAction: _nextStep, condition: emailConfirm && pwFirstConfirm && pwSecondConfirm)
              ]
            )
          )
        )
      )
    );
  }

  @override
  void dispose() {
    // emailController.dispose();
    // pwFirstController.dispose();
    // pwSecondController.dispose();
    // emailFocus.dispose();
    // pwFirstFocus.dispose();
    // pwSecondController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if(emailController.text != '' && pwSecondConfirm) {
      // Navigator.push(context, MaterialPageRoute(builder: (context) => PhoneAuthView()));
      navigatorPush(context: context, widget: ProfileSetupView(emailController.text, pwSecondController.text));
    }
  }
}