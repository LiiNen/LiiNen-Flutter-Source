import 'package:flutter/material.dart';
import 'package:my_flutter_source/containerCollection.dart';
import 'package:my_flutter_source/main.dart';
import 'package:my_flutter_source/functionCollection.dart';

class CategorySetupView extends StatefulWidget {
  @override
  State<CategorySetupView> createState() => _CategorySetupView();
}
class _CategorySetupView extends State<CategorySetupView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LoginViewAppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 21  * responsiveScale),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.white),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 24 * responsiveScale),
                Text('관심 카테고리 선택', style: textStyle(weight: 700, size: 20.0)),
                SizedBox(height: 16 * responsiveScale),
                Text('관심있는 카테고리를 선택해주세요', style: textStyle(weight: 400, size: 16.0)),
                SizedBox(height: 24 * responsiveScale),
                Wrap(
                  direction: Axis.horizontal,
                  spacing: 8, runSpacing: 8,
                  children: [
                    _categoryItem('운동(스포츠/피트니스'),
                    _categoryItem('공예 DIY'),
                    _categoryItem('예술 악기 그림'),
                    _categoryItem('자기계발 독서 스터디'),
                    _categoryItem('안녕'),
                    _categoryItem('하세요'),
                    _categoryItem('ㅎㅎ'),
                    _categoryItem('안녕'),
                    _categoryItem('하세요'),
                    _categoryItem('ㅎㅎ'),
                  ],
                )
              ]
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
                    color: Color(0xffd1d5d9)
                  ),
                  child: Center(child: Text('가입 완료', style: textStyle(color: Colors.white, weight: 600, size: 16.0)))
                ),
                onTap: () => {}
              ),
            )
          ],
        )
      )
    );
  }

  Container _categoryItem(String title) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        border: Border.all(color: Color(0xffd3d7df), width: 1)
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 7.5, horizontal: 12),
        child: Text(title)
      )
    );
  }
}