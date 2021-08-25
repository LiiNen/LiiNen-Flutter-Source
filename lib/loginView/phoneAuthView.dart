import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_flutter_source/functionCollection.dart';
import 'package:my_flutter_source/loginView/profileSetupView.dart';
import 'package:my_flutter_source/main.dart';
import 'package:my_flutter_source/containerCollection.dart';

import 'loginWidgets.dart';
import 'package:my_flutter_source/constraintCollection.dart';

class PhoneAuthView extends StatefulWidget {
  @override
  State<PhoneAuthView> createState() => _PhoneAuthView();
}
class _PhoneAuthView extends State<PhoneAuthView> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController authController = TextEditingController();
  FocusNode authFocusNode = FocusNode();
  bool isPhoneValid = false;
  bool isAuthSent = false;
  bool isAuthValid = false;
  String _leftTimeText = '';

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
                loginTitle('전화번호 인증'),
                sizedBox(24),
                loginSubtitle('휴대폰 번호'),
                sizedBox(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.58,
                      height: 46,
                      child: TextField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 14 * responsiveScale),
                          enabledBorder: enabledBorderDefault(),
                          focusedBorder: focusedBorderDefault(),
                          hintText: '휴대폰 번호(- 없이 입력)',
                        ),
                        style: textStyle(weight: 600, size: 12.0),
                        onChanged: (value) {setState(() {
                          isPhoneValid = phoneRegexCheck(value);
                        });},
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.send,
                        onSubmitted: (value) {if(isPhoneValid) sendAuth();},
                      ),
                    ),
                    GestureDetector(
                      onTap: () {if(isPhoneValid) sendAuth();},
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.27,
                        height: 46,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          color: isPhoneValid ? Color(0xff0958c5) : Color(0xffd1d5d9),
                        ),
                        child: Center(
                          child: Text('인증번호 전송', style: textStyle(color: isPhoneValid ? Colors.white : Color(0xff8a8a8a), weight: 400, size: 12.0))
                        )
                      )
                    )
                  ]
                )
              ] + (isAuthSent ? [
                sizedBox(20),
                loginSubtitle('인증번호'),
                sizedBox(8),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 46,
                  child: TextField(
                    controller: authController,
                    focusNode: authFocusNode,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 14 * responsiveScale),
                      enabledBorder: enabledBorderDefault(),
                      focusedBorder: focusedBorderDefault(),
                      hintText: '인증번호'
                    ),
                    style: textStyle(weight: 600, size: 12.0),
                    onChanged: (value) {setState(() {
                      isAuthValid = authRegexCheck(value);
                    });},
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (value) {_nextStep();}
                  ),
                ),
                sizedBox(4),
                Text(_leftTimeText, style: textStyle(color: Color(0xffd93826), weight: 400, size: 12.0),),
                sizedBox(40),
                confirmButton(title: '확인', confirmAction: _nextStep, condition: isAuthValid),
              ] : []),
            )
          )
        )
      )
    );
  }

  void sendAuth() {
    setState(() {
      isAuthSent = true;
      authFocusNode.requestFocus();
      _authTimerStart();
    });
  }

  void _nextStep() {
    if(isAuthValid) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileSetupView()));
      _authTimer.cancel();
    }
  }

  late Timer _authTimer;
  int _leftTime = 180;
  void _authTimerStart() {
    try {
      _authTimer.cancel();
    } catch(e) {
      print('timer not running');
    }
    _leftTime = 180;
    _authTimer = new Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if(_leftTime == 0) {
          _authTimer.cancel();
        } else {
          _leftTime--;
        }
        int _leftMin = (_leftTime/60).floor();
        int _leftSec = _leftTime%60;
        var _leftSecText = _leftSec < 10 ? '0$_leftSec' : '$_leftSec';
        _leftTimeText = '남은 시간: 0$_leftMin분 $_leftSecText초';
      });
    });
  }

  @override
  void dispose() {
    _authTimer.cancel();
    super.dispose();
  }
}