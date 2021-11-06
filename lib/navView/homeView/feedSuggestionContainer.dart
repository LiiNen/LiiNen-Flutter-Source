import 'package:flutter/material.dart';
import 'package:my_flutter_source/clubCollection/feedCardContainer.dart';
import 'package:my_flutter_source/functionCollection.dart';
import 'package:my_flutter_source/constraintCollection.dart';
import 'package:my_flutter_source/containerCollection.dart';
import 'package:my_flutter_source/main.dart';
import 'package:my_flutter_source/restApi/boardApi.dart';

import '../navView.dart';

class FeedSuggestionContainer extends StatefulWidget {
  @override
  State<FeedSuggestionContainer> createState() => _FeedSuggestionContainer();
}
class _FeedSuggestionContainer extends State<FeedSuggestionContainer> {
  List<dynamic> _allSuggestionList = [];
  List<dynamic> _feedSuggestionList = [];
  int take = 3;

  @override
  void initState() {
    super.initState();
    _getFeedSuggestion();
  }

  void _getFeedSuggestion() async {
    var temp = await getBoard();
    if(temp != null) _allSuggestionList = temp;
    _allSuggestionList.shuffle();
    setState(() {
      _feedSuggestionList = _allSuggestionList.take(take).toList();
      take = take + 3;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    print(_feedSuggestionList);
    return Column(
      children: <Widget>[TitleContainer(title: '뭐하고 있을까?', size: 20.0)] +
        List<Widget>.generate(_feedSuggestionList.length * 2, (index){
          return index%2 == 0 ? FeedCardContainer(feedObject: _feedSuggestionList[(index/2).floor()], isSuggestion: true) : sizedBox(8);
        }) + [
        GestureDetector(
          onTap: () {
            if(take == 12 || take > _allSuggestionList.length) {
              navigatorPush(context: context, widget: NavView(selectedIndex: 1), replacement: true, all: true);
            }
            else {
              setState(() {
                _feedSuggestionList = _allSuggestionList.take(take).toList();
                take = take + 3;
              });
            }
          },
          child: Container(
            decoration: shadowBoxDecoration(),
            width: MediaQuery.of(context).size.width,
            height: 48 * responsiveScale,
            margin: EdgeInsets.symmetric(horizontal: 21 * responsiveScale, vertical: 16 * responsiveScale),
            child: Center(child: Text('피드 더 보기', style: textStyle(weight: 700, size: 14.0)),)
          )
        ),
      ]
    );
  }
}