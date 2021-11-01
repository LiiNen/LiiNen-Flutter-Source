import 'package:flutter/material.dart';

import 'package:my_flutter_source/containerCollection.dart';
import 'package:my_flutter_source/constraintCollection.dart';
import 'package:my_flutter_source/adMob/adMobItem.dart';

import 'package:my_flutter_source/clubCollection/clubCardContainer.dart';


class ResultClubContainer extends StatefulWidget {
  final List<dynamic> _results;
  final bool isSearch;
  ResultClubContainer(this._results, this.isSearch);

  @override
  State<ResultClubContainer> createState() => _ResultClubContainer(_results, isSearch);
}
class _ResultClubContainer extends State<ResultClubContainer> {
  List<dynamic> _results;
  bool isSearch;
  _ResultClubContainer(this._results, this.isSearch);

  @override
  Widget build(BuildContext context) {
    var _resultClubListView = List<Widget>.generate(_results.length * 2, (index) {
      return index%2 == 0 ? ClubCardContainer(_results[(index/2).floor()], isSearch) : sizedBox(8);
    });

    // 광고 삭제할 수 있도록 만들어야함
    if(_resultClubListView.length > 2) {
      _resultClubListView.insert(2, AdMobBanner());
      _resultClubListView.insert(3, LineDivider());
    }

    return Column(
      children: _resultClubListView
    );
  }
}

