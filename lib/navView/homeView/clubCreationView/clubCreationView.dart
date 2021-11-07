import 'package:flutter/material.dart';
import 'package:my_flutter_source/constraintCollection.dart';
import 'package:my_flutter_source/containerCollection.dart';
import 'package:my_flutter_source/functionCollection.dart';
import 'package:my_flutter_source/main.dart';
import 'package:my_flutter_source/restApi/categoriesApi.dart';

import 'clubDetailSetupView.dart';

class ClubCreationView extends StatefulWidget {
  @override
  State<ClubCreationView> createState() => _ClubCreationView();
}
class _ClubCreationView extends State<ClubCreationView> {
  var _selectedId = '';
  var _categories = [];
  String _selectedCategory = '';

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
      appBar: MainViewAppBar(title: '모임개설', back: true),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 21 * responsiveScale),
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizedBox(16),
                TitleContainer(title: '관심사 선택', size: 20.0, margin: false,),
                sizedBox(8),
                Wrap(
                  direction: Axis.horizontal,
                  spacing: 8, runSpacing: 8,
                  children: _categories.map((e) => _categorySetItem(e)).toList(),
                )
              ],
            ),
            Positioned(
              bottom: 56 * responsiveScale,
              child: GestureDetector(
                child: Container(
                  width: MediaQuery.of(context).size.width - 42 * responsiveScale,
                  height: 52 * responsiveScale,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: _selectedCategory != '' ? Color(0xff0958c5) : Color(0xffd1d5d9)
                  ),
                  child: Center(child: Text('다음으로', style: textStyle(color: Colors.white, weight: 600, size: 16.0)))
                ),
                onTap: () => {_nextStep()}
              ),
            )
          ]
        )
      )

    );
  }

  GestureDetector _categorySetItem(e) {
    bool _isSelected = (_selectedCategory == e['name']);
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = e['name'];
          _selectedId = e['_id'];
        });
      },
      child: categoryItem(e['name'], _isSelected),
    );
  }

  void _nextStep() {
    if(_selectedCategory != '') Navigator.push(context, MaterialPageRoute(builder: (context) => ClubDetailSetupView(id: _selectedId)));
  }
}