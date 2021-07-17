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
        width: MediaQuery.of(context).size.width,
        child: Text('검색하기', textAlign: TextAlign.left,),
      ),
      Container(
        child: TextField(
          focusNode: focusNode,
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
        width: MediaQuery.of(context).size.width,
        child: Text('카테고리', textAlign: TextAlign.left,)
      ),
      Container(
        child: GridView.count(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20),
          crossAxisCount: 2,
          children: categoryContainerList,
        )
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
final List<Widget> categoryContainerList = List<Widget>.generate(categoryList.length, (index) {
  return Container(
    padding: const EdgeInsets.all(50),
    height: 150,
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Colors.black,
        ),
        borderRadius: BorderRadius.all(Radius.circular(5))
      ),
      child: Text(categoryList[index])
    )
  );
});