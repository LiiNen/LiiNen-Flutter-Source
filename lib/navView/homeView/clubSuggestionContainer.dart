import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_flutter_source/clubCollection/clubCardContainer.dart';
import 'package:my_flutter_source/constraintCollection.dart';
import 'package:my_flutter_source/main.dart';
import 'package:my_flutter_source/containerCollection.dart';
import 'package:my_flutter_source/functionCollection.dart';
import 'package:my_flutter_source/navView/searchView/searchResult/searchFilterView.dart';
import 'package:my_flutter_source/restApi/meetingsApi.dart';

import '../navView.dart';

class ClubSuggestionContainer extends StatefulWidget {
  @override
  State<ClubSuggestionContainer> createState() => _ClubSuggestionContainer();
}
class _ClubSuggestionContainer extends State<ClubSuggestionContainer> {
  List<dynamic> _allSuggestionList = [];
  List<dynamic> _clubSuggestionList = [];
  int take = 3;

  @override
  void initState() {
    super.initState();
    _getClubSuggestion();
  }

  void _getClubSuggestion() async {
    _allSuggestionList = await getMeetings();
    _allSuggestionList.shuffle();
    setState(() {
      _clubSuggestionList = _allSuggestionList.take(take).toList();
      take = take + 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[TitleContainer(title: '추천 모임', size: 20.0)] +
        List<Widget>.generate(_clubSuggestionList.length * 2, (index){
          return index%2 == 0 ? ClubCardContainer(_clubSuggestionList[(index/2).floor()], true) : sizedBox(8);
        }) + [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            if(take == 12 || take > _allSuggestionList.length) {
              navigatorPush(context: context, widget: NavView(selectedIndex: 1), replacement: true, all: true);
            }
            else {
              setState(() {
                _clubSuggestionList = _allSuggestionList.take(take).toList();
                take = take + 3;
              });
            }
          },
          child: Container(
            decoration: shadowBoxDecoration(),
            width: MediaQuery.of(context).size.width,
            height: 48 * responsiveScale,
            margin: EdgeInsets.symmetric(horizontal: 21 * responsiveScale, vertical: 16 * responsiveScale),
            child: Center(child: Text('모임 더 보기', style: textStyle(weight: 700, size: 14.0)),)
          )
        ),
        LineDivider()
      ]
    );
  }

}