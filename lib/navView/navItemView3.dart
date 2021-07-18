import 'package:flutter/material.dart';

class NavItemView3 extends StatefulWidget {
  @override
  State<NavItemView3> createState() => _NavItemView3();
}

class _NavItemView3 extends State<NavItemView3> {
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _searchByText = [
      Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: Text('검색하기', textAlign: TextAlign.left,),
      ),
      Container(
        height: 10,
        color: Colors.black,
      ),
      Container(
        child: TextField(
          focusNode: focusNode,
          autofocus: true,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            border: InputBorder.none,
            icon: Padding(
                padding: EdgeInsets.zero,
                child: Icon(Icons.search)
            )
          ),
          onChanged: (_text) {_textChangedListner(_text);},
          onSubmitted: (_text) {_textReturnListener(_text);},
        )
      )
    ];

    List<Widget> _searchByCategory = [
      Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: Text('카테고리', textAlign: TextAlign.left,)
      ),
      Container(
        height: 10,
        color: Colors.black,
      ),
      Container(
        child: categoryContainer(context)
      )
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('검색하기')
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[] + _searchByText + _searchByCategory
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
  return Container(
    padding: const EdgeInsets.all(20),
    width: MediaQuery.of(context).size.width / 2,
    height: 100,
    child: Container(
      decoration: _empty ? null : BoxDecoration(
          border: Border.all(width: 2, color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(5))
      ),
      child: _empty ? null : Center(
        child: Text(categoryList[_index])
      )
    )
  );
}
Widget categoryContainer(BuildContext context) {
  return Column(
    children: List<Widget>.generate((categoryList.length / 2).ceil() , (_index) {
      var _leftComponent = categoryContainerGenerator(false, _index*2, context);
      var _rightComponent = (_index*2)+1 < categoryList.length ? categoryContainerGenerator(false, _index*2+1, context) : categoryContainerGenerator(true, 0, context);
      return Row(
        children: [_leftComponent, _rightComponent],
      );
    })
  ) ;
}