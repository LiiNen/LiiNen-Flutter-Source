import 'package:flutter/material.dart';
import 'package:my_flutter_source/clubObject.dart';
import 'package:my_flutter_source/functionCollection.dart';
import 'package:my_flutter_source/main.dart';

class ClubSuggestionContainer extends StatefulWidget {
  @override
  State<ClubSuggestionContainer> createState() => _ClubSuggestionContainer();
}
class _ClubSuggestionContainer extends State<ClubSuggestionContainer> {
  List<ClubObject> _clubObjectList = [];
  var futureTestObject;
  @override
  void initState() {
    super.initState();
    futureTestObject = new Future.delayed(Duration(seconds: 2), _loadTestSuggestion);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 21 * responsiveScale, right: 6 * responsiveScale),
      height: 181 * responsiveScale,
      child: new ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _clubObjectList.length,
        itemBuilder: (BuildContext context, int index) {
          return ClubSuggestionItem(_clubObjectList[index], index);
        }
      )
    );
  }

  void _loadTestSuggestion() async {
    setState(() {
      _clubObjectList = clubObjectList;
    });
  }
}

class ClubSuggestionItem extends StatefulWidget {
  final ClubObject _variable;
  final int _index;
  ClubSuggestionItem(this._variable, this._index);

  @override
  State<ClubSuggestionItem> createState() => _ClubSuggestionItem(_variable, _index);
}
class _ClubSuggestionItem extends State<ClubSuggestionItem> {
  final ClubObject _variable;
  final int _index;
  _ClubSuggestionItem(this._variable, this._index);

  // TODO : pixel overflow
  @override
  Widget build(BuildContext context) {
    return Container(
      width: (217 + 15) * responsiveScale,
      height: 181 * responsiveScale,
      margin: EdgeInsets.only(right: 15 * responsiveScale),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 217 * responsiveScale, height: 108 * responsiveScale,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(_variable.clubImgSrc),
                fit: BoxFit.cover
              )
            ),
          ),
          SizedBox(height: 8 * responsiveScale),
          Text(_variable.clubName, style: textStyle(weight: 700, size: 12.0), textAlign: TextAlign.left,),
          SizedBox(height: 4 * responsiveScale),
          Text(_variable.clubContext, style: textStyle(weight: 400, size: 10.0), textAlign: TextAlign.left,),
          SizedBox(height: 6 * responsiveScale),
          Container(
            height: 16,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.5)),
              border: Border.all(color: Color(0xff0958c5), width: 1),
              color: Color(0xffffffff),
            ),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Text(_variable.clubGenre, style: textStyle(color: Color(0xff0958c5), weight: 400, size: 6.0),)
            )
          )
        ],
      )
    );
  }
}