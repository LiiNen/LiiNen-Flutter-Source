import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:my_flutter_source/containerCollection.dart';
import 'package:my_flutter_source/functionCollection.dart';
import 'package:my_flutter_source/main.dart';

import 'loginWidgets.dart';
import 'signUpView.dart';

class PolicyView extends StatefulWidget {
  @override
  State<PolicyView> createState() => _PolicyView();
}
class _PolicyView extends State<PolicyView> {
  List<bool> _checkList = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LoginViewAppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 21 * responsiveScale),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.white),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24 * responsiveScale),
                loginTitle('환영합니다.'),
                SizedBox(height: 16 * responsiveScale),
                Text('아래 약관에 동의하시고\n'
                    '이건모임에서 목표를 이루어 보세요',
                  style: textStyle(weight: 400, size: 16.0),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 52 * responsiveScale),
                LineDivider(color: Color(0xffd1d5d9)),
                SizedBox(height: 16 * responsiveScale),
                _checkBoxRow(0, '모두 동의합니다.', false, textStyle(weight: 600, size: 18.0)),
                SizedBox(height: 16 * responsiveScale),
                LineDivider(color: Color(0xffd1d5d9)),
                SizedBox(height: 16 * responsiveScale),
                _checkBoxRow(1, '(필수) 이용약관', true, textStyle(color: Color(0xff636c73), weight: 400, size: 14.0)),
                SizedBox(height: 20 * responsiveScale),
                _checkBoxRow(2, '(필수) 개인정보 수집 및 이용에 대한 안내', true, textStyle(color: Color(0xff636c73), weight: 400, size: 14.0)),
                SizedBox(height: 20 * responsiveScale),
                _checkBoxRow(3, '(필수) 위치기반 서비스 이용 약관 동의', true, textStyle(color: Color(0xff636c73), weight: 400, size: 14.0)),
              ],
            ),
            Positioned(
              bottom: 36 * responsiveScale,
              child: GestureDetector(
                child: Container(
                  width: MediaQuery.of(context).size.width - 42 * responsiveScale,
                  height: 52 * responsiveScale,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4)
                    ),
                    color: _check() ? Color(0xff0958c5) : Color(0xffd1d5d9)
                  ),
                  child: Center(child: Text('시작하기', style: textStyle(color: Colors.white, weight: 600, size: 16.0)))
                ),
                onTap: () => _check() ? {Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpView()))} : {},
              ),
            )
          ],
        )
      )
    );
  }

  Container _checkBoxRow(int index, String title, bool detailBool, TextStyle style) {
    return Container(
      height: 24,
      width: MediaQuery.of(context).size.width - 42 * responsiveScale,
      child:
      GestureDetector(
        onTap: () => {_checkBoxTap(index)},
        child: Row(
          children: [
            Container(
              width: 24 * responsiveScale, height: 24 * responsiveScale,
              child: SvgPicture.asset(_checkList[index] ? 'asset/image/checkBoxCheck.svg' : 'asset/image/checkBoxUncheck.svg'),
            ),
            SizedBox(width: 8 * responsiveScale),
            Container(
              width: MediaQuery.of(context).size.width - 98 * responsiveScale,
              child: Text(title, style: style,),
            ),
            GestureDetector(
              // TODO: 상세 이용 약관 등등등 + > 버튼 크기 키우기
              onTap: () => {print('hello')},
              child: Container(
                width: 24 * responsiveScale, height: 24 * responsiveScale,
                child: detailBool ? SvgPicture.asset('asset/loginView/iconArrow.svg') : Container()
              )
            ),
          ],
        )
      )
    );
  }

  void _checkBoxTap(index) {
    setState(() {
      if(index == 0) {
        _checkList[0] = _checkList[1] = _checkList[2] = _checkList[3] = (_check() ? false : true);
      }
      else {
        _checkList[index] = !_checkList[index];
        if(_checkList[0] && !_checkList[index]) _checkList[0] = false;
        if(_check()) _checkList[0] = true;
      }
    });
  }

  bool _check() {
    return (_checkList[1] && _checkList[2] && _checkList[3] ? true : false);
  }
}