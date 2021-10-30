import 'package:flutter/material.dart';
import 'package:my_flutter_source/constraintCollection.dart';
import 'package:my_flutter_source/containerCollection.dart';
import 'package:my_flutter_source/loginView/loginWidgets.dart';
import 'package:my_flutter_source/main.dart';
import 'package:my_flutter_source/functionCollection.dart';
import 'package:my_flutter_source/navView/navView.dart';
import 'package:my_flutter_source/restApi/categoriesApi.dart';
import 'package:my_flutter_source/restApi/loginApi.dart';

class CategorySetupView extends StatefulWidget {
  final String name;
  final String email;
  final String password;
  final String introduce;
  CategorySetupView(this.name, this.email, this.password, this.introduce);

  @override
  State<CategorySetupView> createState() => _CategorySetupView(name, email, password, introduce);
}
class _CategorySetupView extends State<CategorySetupView> {
  String name, email, password, introduce;
  _CategorySetupView(this.name, this.email, this.password, this.introduce);

  var _categories = [];
  List<String> _selectedList = [];
  bool _selectedLeast = false;

  @override
  void initState() {
    super.initState();
    _getCategories();
  }

  void _getCategories() async {
    var _temp = await getCategories();
    setState(() {
      _categories = _temp;
    });
  }

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
                  children: _categories.map((e) => _categoryItem(e)).toList(),
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

  GestureDetector _categoryItem(e) {
    bool _selected = _selectedList.indexOf(e['_id']) != -1;
    return GestureDetector(
      onTap: () => {setState(() {
        if(_selected) {
          _selectedList.remove(e['_id']);
        }
        else {
          _selectedList.add(e['_id']);
          _selectedLeast = (_selectedList.length != 0);
        }
      })},
      child: categoryItem(e['name'], _selected)
    );
  }

  void _submitSignUp() async {
    var result = await signUpApi(name: name, email: email, password: password, introduce: introduce, categories: _selectedList);
    if(result) {
      showToast('회원가입이 완료되었습니다!');
      Navigator.push(context, MaterialPageRoute(builder: (context) => NavView()));
    }
    else {
      showToast('문제가 발생했습니다. 문의해주세요');
    }
  }
}