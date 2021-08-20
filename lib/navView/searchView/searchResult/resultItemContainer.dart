import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_flutter_source/main.dart';
import 'resultItemObject.dart';
import 'package:my_flutter_source/functionCollection.dart';

class ResultItemContainer extends StatefulWidget {
  @override
  State<ResultItemContainer> createState() => _ResultItemContainer();
}
class _ResultItemContainer extends State<ResultItemContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.white),
        child: testObjectList.length != 0 ? Stack(
          children: [
            Positioned(
              top: 16 * responsiveScale,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 21 * responsiveScale),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('${testObjectList.length}건의 검색결과', style: textStyle(weight: 700, size: 14.0)),
                        Container(
                            width: 42 * responsiveScale, height: 24 * responsiveScale,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                              color: Color(0xfff3f3f3),
                            ),
                            child: Center(
                                child: Text('필터', style: textStyle(color: Color(0xff666666), weight: 400, size: 10.0))
                            )
                        )
                      ]
                  )
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 40 * responsiveScale),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: [
                    ResultClubContainer()
                  ],
                )
            )
          ],
        ) : Container(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset('asset/image/icoFail.svg', width: 28, height: 48),
                SizedBox(height: 24),
                Text('검색 결과가 없습니다.', style: textStyle(weight: 600, size: 16.0),),
              ],
            )
          )
        )
    );
  }
}