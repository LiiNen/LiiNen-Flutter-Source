import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_flutter_source/main.dart';
import 'package:my_flutter_source/functionCollection.dart';
import 'resultItemContainer.dart';

class CategoryResultView extends StatefulWidget {
  final String _category;
  CategoryResultView(this._category);

  @override
  State<CategoryResultView> createState() => _CategoryResultView(_category);
}
class _CategoryResultView extends State<CategoryResultView> {
  String _category;
  _CategoryResultView(this._category);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CategoryAppBar(currentCategory: _category,),
      body: ResultItemContainer()
    );
  }
}

class CategoryAppBar extends StatefulWidget implements PreferredSizeWidget {
  CategoryAppBar({required this.currentCategory}) : preferredSize = Size.fromHeight(40.0);
  @override
  final Size preferredSize;
  final String currentCategory;

  @override
  State<CategoryAppBar> createState() => _CategoryAppBar(currentCategory);
}
class _CategoryAppBar extends State<CategoryAppBar> {
  String _currentCategory;
  _CategoryAppBar(this._currentCategory);

  @override
  Widget build(BuildContext context) {
    int categoryIndex = categoryNameList.indexOf(_currentCategory);
    return AppBar(
      elevation: 1,
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Container(
        child: GestureDetector(
          onTap: () => {
            setState(() {
              showCategoryList();
              print(_currentCategory);
            })
          },
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  '$_currentCategory (${categoryDetailList[categoryIndex]})',
                  style: textStyle(weight: 700, size: 16.0),
                  textAlign: TextAlign.center,
                ),
              ),
              Positioned(right: 0, child: Icon(Icons.arrow_drop_down, color: Colors.black, size: 24))
            ]
          )
        )
      ),
      flexibleSpace: Stack(children: [
        Positioned(
          bottom: 8, left: 21,
          child: GestureDetector(
            onTap: () {Navigator.pop(context);},
            child: SvgPicture.asset('asset/image/icoBack.svg', width: 24, height: 24),
          ),
        )
      ]),
    );
  }

  showCategoryList() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            color: Colors.white,
          ),
          padding: EdgeInsets.only(left: 28 * responsiveScale),
          width: MediaQuery.of(context).size.width,
          height: 452 * responsiveScale,
          child: Stack(
            children: [
              Positioned(
                top: 8 * responsiveScale,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text('카테고리 선택', style: textStyle(color: Color(0xff8a8a8a), weight: 700, size: 12.0), textAlign: TextAlign.left,)
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 63 * responsiveScale),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: List<Widget>.generate(categoryList.length, (index) {
                    var _selected = (_currentCategory == categoryList[index].name);
                    return GestureDetector(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                '${categoryList[index].name} (${categoryList[index].detail})',
                                style: _selected
                                  ? textStyle(color: Color(0xff0958c5), weight: 700, size: 14.0)
                                  : textStyle(color: Colors.black, weight: 600, size: 14.0)
                              ),
                            ),
                            Container(
                              child: _selected ? Container(
                                width: 24, height: 24,
                                margin: EdgeInsets.only(right: 31),
                                child: SvgPicture.asset('asset/image/icoCheck.svg')
                              ) : Container()
                            )
                          ]
                        )
                      ),
                      onTap: ((){
                        Navigator.pop(context);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CategoryResultView(categoryList[index].name)));
                      })
                    );
                  }),
                ),
              )
            ]
          )
        );
      }
    );
  }
}


class CategoryComponent {
  final String name;
  final String detail;
  CategoryComponent(this.name, this.detail);
}

var categoryList = List<CategoryComponent>.generate(categoryNameList.length, (index) => CategoryComponent(categoryNameList[index], categoryDetailList[index]));