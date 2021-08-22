import 'package:flutter/material.dart';
import 'package:my_flutter_source/clubCollection/clubCardContainer.dart';
import 'package:my_flutter_source/constraintCollection.dart';
import 'package:my_flutter_source/main.dart';
import 'package:my_flutter_source/containerCollection.dart';
import 'package:my_flutter_source/functionCollection.dart';

class ClubSuggestionContainer extends StatefulWidget {
  @override
  State<ClubSuggestionContainer> createState() => _ClubSuggestionContainer();
}
class _ClubSuggestionContainer extends State<ClubSuggestionContainer> {
  List<ClubCardObject> _clubObjectList = [];
  var futureTestObject;

  @override
  void initState() {
    super.initState();
    futureTestObject = new Future.delayed(Duration(seconds: 2), _loadTestSuggestion);
  }

  @override
  Widget build(BuildContext context) {
    var _clubSuggestionList = List<Widget>.generate(_clubObjectList.length * 2, (index){
      return index%2 == 0 ? ClubCardContainer(_clubObjectList[(index/2).floor()]) : sizedBox(8);
    });

    return Column(
      children: <Widget>[TitleContainer(title: '추천 모임', size: 20.0)] + _clubSuggestionList
        + (_clubObjectList.length < testObjectList.length ? [
          GestureDetector(
            onTap: () {
              setState(() {
                _clubObjectList.add(testObjectList[_clubObjectList.length]);
              });
            },
            child: Container(
              decoration: shadowBoxDecoration(),
              width: MediaQuery.of(context).size.width,
              height: 48 * responsiveScale,
              margin: EdgeInsets.symmetric(horizontal: 21 * responsiveScale, vertical: 16 * responsiveScale),
              child: Center(child: Text('모임 더 보기', style: textStyle(weight: 700, size: 14.0)),)
            )
          )
        ] : [sizedBox(16)]) + [LineDivider()],
    );
  }

  void _loadTestSuggestion() async {
    setState(() {
      _clubObjectList = List<ClubCardObject>.generate(3, (index) {
        return testObjectList[index];
      });
    });
  }
}