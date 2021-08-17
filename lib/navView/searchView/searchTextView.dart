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

  List<String> searchHistoryList = [];
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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 21 * responsiveScale),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.white),
        child: GestureDetector(
          onTap: () => {},
          child: Column(
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
                    autofocus: true,
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
                    onChanged: (value) => {textChangeListener(value)},
                    onSubmitted: (value) => {searchWithText(value)},
                  )
                )
              )
            ],
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
    searchHistoryList.insert(0, input);
    pref.setStringList('searchHistory', searchHistoryList);

    if(searchInputController.text != '') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => SearchTextResult(searchText: searchInputController.text)));
    }
  }
}