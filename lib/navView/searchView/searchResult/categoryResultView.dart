import 'package:flutter/material.dart';
import 'package:my_flutter_source/functionCollection.dart';
import 'resultItemObject.dart';

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
      appBar: CategoryAppBar(currentCategory: _category,),
      body: ListView(
       scrollDirection: Axis.vertical,
       shrinkWrap: true,
       children: [
         ResultClubContainer()
       ],
      )
    );
  }
}

class CategoryAppBar extends StatefulWidget implements PreferredSizeWidget{
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
    GlobalKey titleKey = GlobalKey();
    int categoryIndex = categoryNameList.indexOf(_currentCategory);
    return AppBar(
      elevation: 0,
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: IconButton(
        padding: EdgeInsets.only(left: 0),
        icon: Icon(Icons.arrow_back, color: Colors.black,),
        onPressed: () {Navigator.pop(context);},
      ),
      title: Container(
        child: GestureDetector(
          onTap: () => {print(_currentCategory)},
          child: Stack(
            children: [
              Container(
                width: 200,
                child: Text(
                  '$_currentCategory(${categoryDetailList[categoryIndex]})',
                  style: textStyle(weight: 700, size: 16.0),
                  textAlign: TextAlign.center,
                  key: titleKey,
                ),
              ),
              Positioned(right: 0, child: Icon(Icons.arrow_drop_down, color: Colors.black, size: 24))
            ]
          )
        )
      ),
    );
  }
}

List<String> categoryNameList = ['운동', '공예', '예술', '자기계발', 'IT', '오락', '자유주제'];
List<String> categoryDetailList = ['스포츠/피트니스', 'DIY', '악기/그림', '독서/스터디', '개발/디자인', '온라인/보드게임', '(기타)'];
List<DropdownMenuItem<String>> categoryItemList = List<DropdownMenuItem<String>>.generate(categoryNameList.length, (index){
  return DropdownMenuItem(
    value: categoryNameList[index],
    child: SizedBox(
      height: 20,
      child: Center(child: Text(categoryNameList[index], style: TextStyle(color: Colors.black), textAlign: TextAlign.center,))
    ),
  );
});
