import 'package:flutter/material.dart';
import 'package:my_flutter_source/main.dart';

class ClubSuggestionVariable {
  String _name;
  ClubSuggestionVariable(this._name);
}

class ClubSuggestionContainer extends StatefulWidget {
  @override
  State<ClubSuggestionContainer> createState() => _ClubSuggestionContainer();
}
class _ClubSuggestionContainer extends State<ClubSuggestionContainer> {
  List<ClubSuggestionVariable> clubSuggestionVariableList = [];
  var futureTestObject;
  @override
  void initState() {
    super.initState();
    futureTestObject = new Future.delayed(Duration(seconds: 2), _loadTestSuggestion);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 181 * responsiveScale,
      child: new ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: clubSuggestionVariableList.length,
        itemBuilder: (BuildContext context, int index) {
          return ClubSuggestionItem(clubSuggestionVariableList[index]);
        }
      )
    );
  }

  void _loadTestSuggestion() async {
    setState(() {
      clubSuggestionVariableList = [ClubSuggestionVariable("1"), ClubSuggestionVariable("2"), ClubSuggestionVariable("3"), ClubSuggestionVariable("4")];
    });
  }
}

class ClubSuggestionItem extends StatefulWidget {
  final ClubSuggestionVariable _variable;
  ClubSuggestionItem(this._variable);

  @override
  State<ClubSuggestionItem> createState() => _ClubSuggestionItem(_variable);
}
class _ClubSuggestionItem extends State<ClubSuggestionItem> {
  final ClubSuggestionVariable _variable;
  _ClubSuggestionItem(this._variable);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 217 + 15,
      height: 181 * responsiveScale,
      padding: EdgeInsets.all(5),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(5)
        ),
        child: Row(
          children: [
            FlutterLogo(size: 80),
            Column(
              children: [
                Text(_variable._name),
                Text('123123123123123123',
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            )
          ],
        )
      )
    );
  }
}