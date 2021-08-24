import 'package:flutter/material.dart';
import 'package:my_flutter_source/constraintCollection.dart';
import 'package:my_flutter_source/containerCollection.dart';
import 'package:my_flutter_source/loginView/loginWidgets.dart';
import 'package:my_flutter_source/main.dart';
import 'package:my_flutter_source/functionCollection.dart';
import 'package:my_flutter_source/navView/navView.dart';

class CategorySetupView extends StatefulWidget {
  @override
  State<CategorySetupView> createState() => _CategorySetupView();
}
class _CategorySetupView extends State<CategorySetupView> {
  bool _selectedLeast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: LoginViewAppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 21  * responsiveScale),
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                sizedBox(24),
                loginTitle('관심 카테고리 선택'),
                sizedBox(24),
                Text('관심있는 카테고리를 선택해주세요', style: textStyle(weight: 400, size: 16.0)),
                sizedBox(24),
                Wrap(
                  direction: Axis.horizontal,
                  spacing: 8, runSpacing: 8,
                  children: _titleList.map((e) => _categoryItem(e)).toList(),
                )
              ]
            ),
            Positioned(
              bottom: 56 * responsiveScale,
              child: confirmButton(title: '가입 완료', confirmAction: _submitSignUp, condition: _selectedLeast)
            )
          ],
        )
      )
    );
  }

  GestureDetector _categoryItem(title) {
    bool _selected = _selectedList[_titleList.indexOf(title)];
    return GestureDetector(
      onTap: () => {setState(() {
        _selectedList[_titleList.indexOf(title)] = !_selected;
        _selectedLeast = _selectedList.indexOf(true) != -1 ? true : false;
      })},
      child: categoryItem(title, _selected)
    );
  }

  void _submitSignUp() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => NavView()));
  }
}

List<String> _titleList = categoryFullList;
List<bool> _selectedList = List<bool>.generate(_titleList.length, (index) => false);