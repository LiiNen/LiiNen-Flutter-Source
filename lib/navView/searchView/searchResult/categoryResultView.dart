import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_flutter_source/main.dart';
import 'package:my_flutter_source/functionCollection.dart';
import 'package:my_flutter_source/restApi/searchApi.dart';
import 'resultItemContainer.dart';

class CategoryResultView extends StatefulWidget {
  final String _category;
  final String _id;
  CategoryResultView(this._category, this._id);

  @override
  State<CategoryResultView> createState() => _CategoryResultView(_category, _id);
}
class _CategoryResultView extends State<CategoryResultView> {
  String _category;
  String _id;
  _CategoryResultView(this._category, this._id);

  var results = [];
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    _searchWithCategory();
  }

  void _searchWithCategory() async {
    var _temp = await searchWithCategory(categoryId: _id);
    setState(() {
      results = _temp;
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CategoryAppBar(currentCategory: _category,),
      body: isLoaded ? ResultItemContainer(results: results) : Container()
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Container(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
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
                  '$_currentCategory',
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
          bottom: 8, left: 21 * responsiveScale,
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
                  children: List<Widget>.generate(categories.length, (index) {
                    var _selected = (_currentCategory == categories[index]['name']);
                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                '${categories[index]['name']}',
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
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CategoryResultView(categories[index]['name'], categories[index]['_id'])));
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
  final String id;
  CategoryComponent(this.name, this.id);
}