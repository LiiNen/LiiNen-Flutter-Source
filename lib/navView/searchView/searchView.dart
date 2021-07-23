import 'package:flutter/material.dart';
import 'searchResult/categoryResultView.dart';
import 'package:my_flutter_source/containerCollection.dart';

class SearchView extends StatefulWidget {
  @override
  State<SearchView> createState() => _SearchView();
}

class _SearchView extends State<SearchView> {
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _searchByText = [
      ComponentTitleContainer('검색하기'),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(5))
          ),
          child: TextField(
            focusNode: focusNode,
            autofocus: false,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              border: InputBorder.none,
              icon: Padding(
                padding: EdgeInsets.only(left: 10, right: 0),
                child: Icon(Icons.search)
              )
            ),
            onChanged: (_text) {_textChangedListner(_text);},
            onSubmitted: (_text) {_textReturnListener(_text);},
          )
        )
      )
    ];

    List<Widget> _searchByCategory = [
      ComponentTitleContainer('카테고리'),
      Container(
        child: categoryContainer(context)
      )
    ];

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('검색하기'))
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: <Widget>[] + _searchByText + _searchByCategory
        )
      )
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }
}

void _textChangedListner(_text) {
  print(_text);
}
void _textReturnListener(_text) {
  print(_text);
}

final List<String> categoryList = ['축구', '농구', '배구', '공부', '코딩', '취업', '뜨개질', '등산', '사이클', '노래', '댄스'];
Widget categoryContainerGenerator(bool _empty, int _index, BuildContext context) {
  String _category = categoryList[_index];

  return Container(
    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
    width: MediaQuery.of(context).size.width / 2,
    height: 80,
    child: _empty ? null : GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryResultView(_category)));
      },
      child: Container(
        decoration:  BoxDecoration(
          border: Border.all(width: 2, color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Center(child: Text(_category)),
      )
    )
  );
}
Widget categoryContainer(BuildContext context) {
  return Column(
    children: List<Widget>.generate((categoryList.length / 2).ceil() , (_index) {
      var _leftComponent = categoryContainerGenerator(false, _index*2, context);
      var _rightComponent = (_index*2)+1 < categoryList.length ?
        categoryContainerGenerator(false, _index*2+1, context) :
        categoryContainerGenerator(true, 0, context);
      return Row(
        children: [_leftComponent, _rightComponent],
      );
    })
  ) ;
}