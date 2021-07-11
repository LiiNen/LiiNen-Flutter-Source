import 'package:flutter/material.dart';

class NavItemView1 extends StatefulWidget {
  @override
  State<NavItemView1> createState() => _NavItemView1();
}

class _NavItemView1 extends State<NavItemView1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[
          HorizontalContainer(),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            color: Colors.lightGreen,
            child: Center(
              child: Text('middle')
            )
          ),
        ] + vertItemsList
      )
    );
  }
}

final List<String> horList = List<String>.generate(20, (index) => 'hello $index');
final List<Widget> vertItemsList = List<Widget>.generate(horList.length, (index) {
  return Column(
    children: [
      Container(
        height: 100,
        color: Colors.lightBlue,
        child: Center(
          child: Text(horList[index])
        )
      ),
      Container(
        height: 10,
        color: Colors.white,
      )
    ],
  );
});

class HorizontalContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: new ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: horList.length,
        itemBuilder: (BuildContext context, int index) {
          return HorizontalItem(horList[index], Colors.orange);
        },
      )
    );
  }
}

class HorizontalItem extends StatelessWidget {
  HorizontalItem(this._text, this._color);
  final String _text;
  final Color _color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: _color,
      margin: EdgeInsets.all(25),
      child: Center(
        child: Text(_text)
      )
    );
  }
}
