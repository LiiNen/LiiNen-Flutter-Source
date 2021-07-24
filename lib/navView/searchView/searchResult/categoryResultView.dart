import 'package:flutter/material.dart';
import 'package:my_flutter_source/navView/searchView/searchView.dart';

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
      body: Center(child: Text(_category))
    );
  }
}

class CategoryAppBar extends StatefulWidget implements PreferredSizeWidget{
  CategoryAppBar({required this.currentCategory}) : preferredSize = Size.fromHeight(kToolbarHeight);
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
    return AppBar(
      centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Container(
          width: 80,
          child: Center(child: DropdownButton<String>(
            dropdownColor: Colors.white,
            underline: SizedBox(height: 0,),
            value: _currentCategory,
            items: categoryItemList.toList(),
            focusColor: Colors.yellow,
            onChanged: (value) {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CategoryResultView(value!)));},
          ))
        )],
      ),
    );
  }
}

List<String> categoryList = ['축구', '농구', '배구', '공부', '코딩', '취업', '뜨개질', '등산', '사이클', '노래', '댄스', 'a', 'b', 'c', 'd', 'e', 'f', 'g'];
List<DropdownMenuItem<String>> categoryItemList = List<DropdownMenuItem<String>>.generate(categoryList.length, (index){
  return DropdownMenuItem(
    value: categoryList[index],
    child: SizedBox(
      height: 20,
      child: Center(child: Text(categoryList[index], style: TextStyle(color: Colors.black), textAlign: TextAlign.center,))
    ),
  );
});
