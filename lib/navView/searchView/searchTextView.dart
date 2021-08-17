import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_flutter_source/containerCollection.dart';
import 'package:my_flutter_source/functionCollection.dart';
import 'package:my_flutter_source/main.dart';
import 'package:my_flutter_source/navView/searchView/searchResult/searchTextResult.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchTextView extends StatefulWidget {
  @override
  State<SearchTextView> createState() => _SearchTextView();
}
class _SearchTextView extends State<SearchTextView> {
  TextEditingController searchInputController = TextEditingController();
  FocusNode searchInputFocusNode = FocusNode();

  List<String> searchHistoryList = [];

  // TODO: 서버 연결 초기화
  List<String> popularList = ['소프트웨어 마에스트로', '리그 오브 레전드', '구글 플러터', '이디야 아이스 아메리카노'];
  @override
  void initState() {
    super.initState();
    _loadSearchHistory();
  }

  void _loadSearchHistory() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      searchHistoryList = pref.getStringList('searchHistory') ?? [];
      print(searchHistoryList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MainViewAppBar(title: '탐색', back: true),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 21 * responsiveScale),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40,
                margin: EdgeInsets.symmetric(vertical: 16 * responsiveScale),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                    color: Color(0xfff5f5f5),
                  ),
                  // TODO : 정중앙이 아닌 문제
                  child: TextField(
                    controller: searchInputController,
                    focusNode: searchInputFocusNode,
                    autofocus: false,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12.5),
                      hintText: '어떤 모임을 찾으시나요?',
                      hintStyle: textStyle(color: Color(0xff8a8a8a), weight: 400, size: 12.0),
                      suffixIcon: searchInputController.text != '' ? IconButton(
                        onPressed: () => {setState(() {textFieldClear(searchInputController);})},
                        icon: SvgPicture.asset('asset/image/icoInputClose.svg', width: 20, height: 20),
                      ) : null
                    ),
                    style: textStyle(weight: 400, size: 12.0),
                    onChanged: (value) => textChangeListener(value),
                    onSubmitted: (value) => searchWithText(value),
                  )
                )
              ),
              SizedBox(height: 28, width: MediaQuery.of(context).size.width),
            ] + (searchHistoryList.length != 0 ? [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('최근 검색어', style: textStyle(weight: 700, size: 16.0), textAlign: TextAlign.left,),
                  GestureDetector(
                    onTap: () => {setState(() {removeRecent(all: true);})},
                    child: Center(
                      child: Text('전체삭제', style: textStyle(color: Color(0xff8a8a8a), weight: 400, size: 12.0))
                    )
                  )
                ],
              ),
              SizedBox(height: 20, width: MediaQuery.of(context).size.width),
              Wrap(
                direction: Axis.horizontal,
                spacing: 8, runSpacing: 8,
                children: searchHistoryList.map((e) => _keywordItem(keyword: e, isRecent: true)).toList(),
              ),
              SizedBox(height: 48),
            ] : []) + (popularList.length != 0 ? [
              Text('인기 검색어', style: textStyle(weight: 700, size: 16.0), textAlign: TextAlign.left,),
              SizedBox(height: 20),
              Wrap(
                direction: Axis.horizontal,
                spacing: 8, runSpacing: 8,
                children: popularList.map((e) => _keywordItem(keyword: e, isRecent: false)).toList(),
              )
            ] : [])
          )
        )
      )
    );
  }

  textChangeListener(input) {
    setState(() {
      print(input);
    });
  }

  searchWithText(String input) async{
    final pref = await SharedPreferences.getInstance();
    searchHistoryList.remove(input);
    searchHistoryList.insert(0, input);
    pref.setStringList('searchHistory', searchHistoryList);

    if(input !='') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => SearchTextResult(searchText: input)));
    }
  }

  removeRecent({String target='', bool all=false}) async {
    final pref = await SharedPreferences.getInstance();
    if(all) {
      searchHistoryList = [];
      pref.setStringList('searchHistory', []);
    }
    else {
      searchHistoryList.remove(target);
      pref.setStringList('searchHistory', searchHistoryList);
    }
  }

  GestureDetector _keywordItem({required String keyword, required bool isRecent}) {
    return GestureDetector(
      onTap: () => {setState(() {
        searchWithText(keyword);
      })},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          border: Border.all(color: Color(0xffd3d7df), width: 1),
          color: isRecent ? Colors.white : Color(0xff0958c5),
        ),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 7.5, horizontal: 12),
          child: (isRecent ?
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(keyword, style: textStyle(weight: 600, size: 14.0)),
                SizedBox(width: 4,),
                GestureDetector(
                  onTap: () => {setState(() {removeRecent(target: keyword);})},
                  child: SvgPicture.asset('asset/image/icoClose.svg', width: 16, height: 16),
                ),
              ],
            ) :
            Text(keyword, style: textStyle(color: Colors.white, weight: 600, size: 14.0))
          )
        )
      )
    );
  }
}