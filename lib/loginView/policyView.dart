import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:my_flutter_source/containerCollection.dart';
import 'package:my_flutter_source/functionCollection.dart';

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
        padding: EdgeInsets.symmetric(horizontal: 21),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.white),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24),
                Text('환영합니다',
                  style: textStyle(weight: 700, size: 20.0),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 16),
                Text('아래 약관에 동의하시고\n'
                    '이건모임에서 목표를 이루어 보세요',
                  style: textStyle(weight: 400, size: 16.0),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 52),
                ColumnVerticalDivider(),
                SizedBox(height: 16),
                _checkBoxRow(0, '모두 동의합니다.', false, textStyle(weight: 600, size: 18.0)),
                SizedBox(height: 16),
                ColumnVerticalDivider(),
                SizedBox(height: 16),
                _checkBoxRow(1, '(필수) 이용약관', true, textStyle(color: Color(0xff636c73), weight: 400, size: 14.0)),
                SizedBox(height: 20),
                _checkBoxRow(2, '(필수) 개인정보 수집 및 이용에 대한 안내', true, textStyle(color: Color(0xff636c73), weight: 400, size: 14.0)),
                SizedBox(height: 20),
                _checkBoxRow(3, '(필수) 위치기반 서비스 이용 약관 동의', true, textStyle(color: Color(0xff636c73), weight: 400, size: 14.0)),
              ],
            ),
            Positioned(
              bottom: 36,
              child: GestureDetector(
                child: Container(
                  width: MediaQuery.of(context).size.width - 42,
                  height: 52,
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
      width: MediaQuery.of(context).size.width - 42,
      child:Row(
        children: [
          GestureDetector(
            onTap: () => {_checkBoxTap(index)},
            child: Container(
              width: 24, height: 24,
              child: SvgPicture.asset(_checkList[index] ? 'asset/image/CheckBoxCheck.svg' : 'asset/image/CheckBoxUncheck.svg'),
            ),
          ),
          SizedBox(width: 8),
          Container(
            width: MediaQuery.of(context).size.width - 98,
            child: Text(title, style: style,),
          ),
          Container(
            width: 24, height: 24,
            child: detailBool ? SvgPicture.asset('asset/image/iconArrow.svg') : Container()
          )
        ],
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