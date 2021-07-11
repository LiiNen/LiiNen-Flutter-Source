import 'package:flutter/material.dart';

class NavItemView1 extends StatefulWidget {
  @override
  State<NavItemView1> createState() => _NavItemView1();
}

class _NavItemView1 extends State<NavItemView1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          HorizontalContainer(),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: Center(
              child: Text('hellooooo')
            )
          )
        ],
      )
    );
  }
}

final List<String> horList = List<String>.generate(20, (index) => 'hello $index');

class HorizontalContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      // width: horList.length * 150,
      child: new ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: horList.length,
        itemBuilder: (BuildContext context, int index) {
          return HorizontalItem(horList[index]);
        },
      )
    );
  }
}

class HorizontalItem extends StatelessWidget {
  HorizontalItem(this._text);
  final String _text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.orange,
      margin: EdgeInsets.all(25),
      child: Center(
        child: Text(_text)
      )
    );
  }
}