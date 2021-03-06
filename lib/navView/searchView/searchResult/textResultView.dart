import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_flutter_source/functionCollection.dart';
import 'package:my_flutter_source/main.dart';
import 'package:my_flutter_source/restApi/searchApi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'resultItemContainer.dart';

class TextResultView extends StatefulWidget {
  final String _text;
  TextResultView(this._text);

  @override
  State<TextResultView> createState() => _TextResultView(_text);
}
class _TextResultView extends State<TextResultView> {
  String _text;
  _TextResultView(this._text);

  var results = [];
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    _searchWithText();
  }

  void _searchWithText() async {
    var _temp = await searchWithWord(word: _text);
    setState(() {
      results = _temp;
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: TextAppBar(text: _text),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: isLoaded ? ResultItemContainer(results: results) : Container(),
      )
    );
  }
}

class TextAppBar extends StatefulWidget implements PreferredSizeWidget {
  TextAppBar({required this.text}) : preferredSize = Size.fromHeight(40);
  @override
  final Size preferredSize;
  final String text;

  @override
  State<TextAppBar> createState() => _TextAppBar(text);
}
class _TextAppBar extends State<TextAppBar> {
  String text;
  _TextAppBar(this.text);

  TextEditingController searchInputController = TextEditingController();
  FocusNode searchInputFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    searchInputFocusNode.addListener(() {
      setState(() {});
    });
  }
  @override
  void dispose() {
    searchInputController.dispose();
    searchInputFocusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      flexibleSpace: Stack(children: [
        Positioned(
          bottom: 8, left: 21 * responsiveScale,
          child: GestureDetector(
            onTap: () {Navigator.pop(context);},
            child: SvgPicture.asset('asset/image/icoBack.svg', width: 24, height: 24),
          ),
        ),
        Positioned(
          bottom: -3, left: 53,
          width: MediaQuery.of(context).size.width-53-21,
          child: TextField(
            controller: searchInputController,
            focusNode: searchInputFocusNode,
            autofocus: false,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: !searchInputFocusNode.hasPrimaryFocus ? text : '',
              hintStyle: textStyle(weight: 400, size: 16.0),
            ),
            style: textStyle(weight: 400, size: 16.0),
            onSubmitted: (value) => {setState(() {searchWithText(value);})},
          )
        ),
        Positioned(
          bottom: 0, right: 21 * responsiveScale,
          child: GestureDetector(
            onTap: () => {setState(() {
              if(searchInputController.text == '') {
                searchInputFocusNode.requestFocus();
              } else {
                textFieldClear(searchInputController);
              }
            })},
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: SvgPicture.asset('asset/image/icoInputClose.svg', width: 20, height: 20),
            )
          )
        )
      ])
    );
  }

  searchWithText(String input) async {
    final pref = await SharedPreferences.getInstance();
    List<String> searchHistoryList = pref.getStringList('searchHistory') ?? [];
    searchHistoryList.remove(input);
    searchHistoryList.insert(0, input);
    pref.setStringList('searchHistory', searchHistoryList);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TextResultView(input)));
  }
}