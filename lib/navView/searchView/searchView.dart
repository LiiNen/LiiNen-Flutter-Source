import 'package:flutter/material.dart';
import 'searchResult/categoryResultView.dart';
import 'package:my_flutter_source/containerCollection.dart';
import 'package:my_flutter_source/main.dart';
import 'package:my_flutter_source/functionCollection.dart';

class SearchView extends StatefulWidget {
  @override
  State<SearchView> createState() => _SearchView();
}

class _SearchView extends State<SearchView> {
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    List<Widget> _searchByText = [
      Container(
        height: 40 * responsiveScale,
        padding: EdgeInsets.symmetric(horizontal: 21 * responsiveScale),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(2)),
            color: Color(0xfff5f5f5),
          ),
          child: TextField(
            focusNode: focusNode,
            autofocus: false,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              border: InputBorder.none,
              icon: Padding(
                padding: EdgeInsets.only(left: 14, right: 0),
                child: Text('어떤 모임을 찾으시나요?', style: textStyle(color: Color(0xff8a8a8a), weight: 400, size: 12.0))
              )
            ),
            onChanged: (_text) {_textChangedListener(_text);},
            onSubmitted: (_text) {_textReturnListener(_text);},
          )
        )
      )
    ];

    List<Widget> _searchByCategory = [
      TitleContainer('카테고리'),
      SizedBox(height: 4),
      Container(
        child: categoryGridContainer(context)
      )
    ];

    return Scaffold(
      appBar: MainViewAppBar(title: '탐색'),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: <Widget>[
                SizedBox(height: 16 * responsiveScale)
              ] + _searchByText + [SizedBox(height: 12 * responsiveScale)] + _searchByCategory
            )
          )
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

void _textChangedListener(_text) {
  print(_text);
}
void _textReturnListener(_text) {
  print(_text);
}

class CategoryItemClass {
  final String title;
  final String context;
  final String imgSrc;
  CategoryItemClass({required this.title, required this.context, required this.imgSrc});
}

final List<CategoryItemClass> categoryList = [
  CategoryItemClass(title: '운동', context: '(스포츠/피트니스)', imgSrc: 'asset/category/sport.jpeg'),
  CategoryItemClass(title: '공예', context: '(DIY)', imgSrc: 'asset/category/diy.jpeg'),
  CategoryItemClass(title: '예술', context: '(악기/그림)', imgSrc: 'asset/category/art.jpeg'),
  CategoryItemClass(title: '자기계발', context: '(독서/스터디)', imgSrc: 'asset/category/reading.jpeg'),
  CategoryItemClass(title: 'IT', context: '(개발/디자인)', imgSrc: 'asset/category/it.jpeg'),
  CategoryItemClass(title: '오락', context: '(온라인/보드게임)', imgSrc: 'asset/category/boardGame.jpeg'),
  CategoryItemClass(title: '자유주제', context: '(기타)', imgSrc: 'asset/category/etc.jpeg')
];

Widget categoryGridContainer(BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 21 * responsiveScale),
    child: GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2, crossAxisSpacing: 15 * responsiveScale,
      mainAxisSpacing: 12 * responsiveScale,
      childAspectRatio: 1.7,
      children: List.generate(categoryList.length, (index){
        return Container(
          child: Stack(
            children: [
              Container(
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return GestureDetector(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryResultView(categoryList[index].title)));
                      },
                      child: Container(
                        width: constraints.maxWidth, height: constraints.maxHeight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          image: DecorationImage(
                            image: AssetImage(categoryList[index].imgSrc),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.srcOver)
                          )
                        )
                      )
                    );
                  }
                )
              ),
              Positioned(
                left: 8 * responsiveScale, bottom: 8 * responsiveScale,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(categoryList[index].title, style: textStyle(color: Colors.white, weight: 400, size: 12.0), textAlign: TextAlign.left,),
                    Text(categoryList[index].context, style: textStyle(color: Colors.white, weight: 400, size: 10.0), textAlign: TextAlign.left,)
                  ],
                )
              )
           ],
          )
        );
      })
    )
  ) ;
}