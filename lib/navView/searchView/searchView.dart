import 'package:flutter/material.dart';
import 'searchResult/categoryResultView.dart';
import 'package:my_flutter_source/containerCollection.dart';
import 'package:my_flutter_source/main.dart';
import 'package:my_flutter_source/functionCollection.dart';
import 'searchTextView.dart';

class SearchView extends StatefulWidget {
  @override
  State<SearchView> createState() => _SearchView();
}

class _SearchView extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    Container _searchByText = Container(
      height: 40,
      width: MediaQuery.of(context).size.width - 42 * responsiveScale,
      margin: EdgeInsets.symmetric(horizontal: 21 * responsiveScale),
      child: GestureDetector(
        onTap: () => {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchTextView()))
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(2)),
            color: Color(0xfff5f5f5),
          ),
          child: Center(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Container(
                  margin: EdgeInsets.only(left: 14 * responsiveScale),
                  width: constraints.maxWidth,
                  child: Text('어떤 모임을 찾으시나요?', style: textStyle(color: Color(0xff8a8a8a), weight: 400, size: 12.0), textAlign: TextAlign.left,)
                );
              },
            )
          )
        )
      )
    );

    Container _searchByCategory = Container(
      margin: EdgeInsets.symmetric(horizontal: 21 * responsiveScale),
      child: categoryGridContainer(context)
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainViewAppBar(title: '탐색'),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Colors.white),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 16,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _searchByText,
                  SizedBox(height: 12),
                  TitleContainer(title: '카테고리'),
                ],
              )
            ),
            Container(
              margin: EdgeInsets.only(top: 108),
              child: _searchByCategory,
            )
          ]
        )
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class CategoryItemClass {
  final String title;
  final String context;
  final String imgSrc;
  final String id;
  CategoryItemClass({required this.title, required this.context, required this.imgSrc, required this.id});
}

var imgSrcList = [
  'asset/category/sport.jpeg', 'asset/category/diy.jpeg', 'asset/category/art.jpeg', 'asset/category/reading.jpeg',
  'asset/category/it.jpeg', 'asset/category/boardGame.jpeg', 'asset/category/etc.jpeg'
];

List<CategoryItemClass> categoryList = List.generate(categories.length, (index) {
  var _split = categories[index]['name'].split(' ');
  return CategoryItemClass(title: _split[0], context: _split.length == 1 ? '' : _split[1], imgSrc: imgSrcList[index], id: categories[index]['_id']);
});

Widget categoryGridContainer(BuildContext context) {
  return Container(
    child: GridView.count(
      padding: EdgeInsets.symmetric(vertical: 15 * responsiveScale),
      scrollDirection: Axis.vertical,
      physics: ScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2, crossAxisSpacing: 15 * responsiveScale,
      mainAxisSpacing: 15 * responsiveScale,
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryResultView('${categoryList[index].title} ${categoryList[index].context}', categoryList[index].id)));
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
                    categoryList[index].context != '' ? Text(categoryList[index].context, style: textStyle(color: Colors.white, weight: 400, size: 10.0), textAlign: TextAlign.left,) : Container()
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