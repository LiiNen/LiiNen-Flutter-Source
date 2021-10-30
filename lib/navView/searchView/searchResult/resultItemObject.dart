import 'package:flutter/material.dart';

import 'package:my_flutter_source/containerCollection.dart';
import 'package:my_flutter_source/constraintCollection.dart';
import 'package:my_flutter_source/adMob/adMobItem.dart';

import 'package:my_flutter_source/clubCollection/clubCardContainer.dart';


class ResultClubContainer extends StatefulWidget {
  final List<dynamic> _results;
  ResultClubContainer(this._results);

  @override
  State<ResultClubContainer> createState() => _ResultClubContainer(_results);
}
class _ResultClubContainer extends State<ResultClubContainer> {
  List<dynamic> _results;
  _ResultClubContainer(this._results);

  @override
  Widget build(BuildContext context) {
    var _resultClubListView = List<Widget>.generate(_results.length * 2, (index) {
      return index%2 == 0 ? ClubCardContainer(_results[(index/2).floor()]) : sizedBox(8);
    });

    // 광고 삭제할 수 있도록 만들어야함
    _resultClubListView.insert(2, AdMobBanner());
    _resultClubListView.insert(3, LineDivider());

    return Column(
      children: _resultClubListView
    );
  }
}

