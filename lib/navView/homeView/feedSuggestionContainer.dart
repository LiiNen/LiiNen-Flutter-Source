import 'package:flutter/material.dart';
import 'package:my_flutter_source/clubCollection/feedCardContainer.dart';
import 'package:my_flutter_source/functionCollection.dart';
import 'package:my_flutter_source/constraintCollection.dart';
import 'package:my_flutter_source/containerCollection.dart';
import 'package:my_flutter_source/main.dart';

class FeedSuggestionContainer extends StatefulWidget {
  @override
  State<FeedSuggestionContainer> createState() => _FeedSuggestionContainer();
}
class _FeedSuggestionContainer extends State<FeedSuggestionContainer> {
  List<FeedCardObject> _feedObjectList = [];

  @override
  void initState() {
    super.initState();
    _feedObjectList = List<FeedCardObject>.generate(3, (index) {
      return testFeedObjectList[index];
    });
  }
  
  @override
  Widget build(BuildContext context) {
    var _feedSuggestionList = List<Widget>.generate(_feedObjectList.length * 2, (index){
      return index%2 == 0 ? FeedCardContainer(_feedObjectList[(index/2).floor()]) : sizedBox(8);
    });

    return Column(
      children: <Widget>[TitleContainer(title: '뭐하고 있을까?', size: 20.0)] + _feedSuggestionList
        + (_feedObjectList.length < testFeedObjectList.length ? [
          GestureDetector(
            onTap: () {
              setState(() {
                _feedObjectList.add(testFeedObjectList[_feedObjectList.length]);
              });
            },
            child: Container(
              decoration: shadowBoxDecoration(),
              width: MediaQuery.of(context).size.width,
              height: 48 * responsiveScale,
              margin: EdgeInsets.symmetric(horizontal: 21 * responsiveScale, vertical: 16 * responsiveScale),
              child: Center(child: Text('피드 더 보기', style: textStyle(weight: 700, size: 14.0)),)
            )
          ),
        ] : [sizedBox(32)]),
    );
  }
}