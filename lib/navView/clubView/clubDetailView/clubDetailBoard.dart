import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_flutter_source/functionCollection.dart';

class ClubDetailBoard extends StatefulWidget {
  @override
  State<ClubDetailBoard> createState() => _ClubDetailBoard();
}
class _ClubDetailBoard extends State<ClubDetailBoard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff8f9fa),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 21, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              boardItemBox()
            ]
          )
        )
      )
    );
  }

  boardItemBox() {
    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          boxShadow: [BoxShadow(
            color: Color(0x338d979e),
            offset: Offset(0,0),
            blurRadius: 30,
            spreadRadius: 0
          )] ,
          color: Color(0xffffffff)
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('title', style: textStyle(weight: 700, size: 14.0)),
              SizedBox(height: 4),
              Text('근로소득이 높은 분들도 있겠지만  근데 그거 외에 어떻게 자산 증식 하고있는지 궁금해~!  나는 집 조그만거(저렴이지만 현 차익은 1.4억이라 나름.. 만족😭) 하나 사놓았구… 부동산은 계속 공…', style: textStyle(weight: 400, size: 10.0)),
              SizedBox(height: 24),
              Text('username', style: textStyle(color: Color(0xff8a8a8a), weight: 400, size: 10.0)),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('asset/image/heartIco.svg', width: 16, height: 16),
                      SizedBox(width: 4),
                      Text('4', style: textStyle(color: Color(0xff8a8a8a), weight: 400, size: 10.0)),
                      SizedBox(width: 12),
                      SvgPicture.asset('asset/image/messageIco.svg', width: 16, height: 16),
                      SizedBox(width: 4),
                      Text('4', style: textStyle(color: Color(0xff8a8a8a), weight: 400, size: 10.0)),
                    ]
                  ),
                  Text('10월 30일 오후04:14', style: textStyle(color: Color(0xff8a8a8a), weight: 400, size: 10.0))
                ]
              )
            ]
          )
        )
      )
    );
  }
}

