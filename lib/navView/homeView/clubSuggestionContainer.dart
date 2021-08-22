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
    var _clubSuggestionList = List<Widget>.generate(_clubObjectList.length, (index){
      return ClubCardContainer(clubObject: _clubObjectList[index], isBorder: true, verticalPadding: 4.0,);
    });

    return Column(
      children: <Widget>[TitleContainer('추천 모임')] + _clubSuggestionList + (_clubObjectList.length < testObjectList.length ? [
        sizedBox(16),
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
            margin: EdgeInsets.symmetric(horizontal: 21 * responsiveScale),
            child: Center(child: Text('모임 더 보기', style: textStyle(weight: 700, size: 14.0)),)
          )
        )
      ] : []),
    );
  }

  void _loadTestSuggestion() async {
    setState(() {
      _clubObjectList = List<ClubCardObject>.generate(3, (index){
        return testObjectList[index];
      });
    });
  }
}