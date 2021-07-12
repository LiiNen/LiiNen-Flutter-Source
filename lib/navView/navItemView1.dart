import 'package:flutter/material.dart';

class NavItemView1 extends StatefulWidget {
  @override
  State<NavItemView1> createState() => _NavItemView1();
}

class _NavItemView1 extends State<NavItemView1> {
  Color inC = Colors.blue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[
          HorizontalContainer(),
          MiddleContainer(),
        ] + vertItemsList
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _inColorChange,
        child: Icon(Icons.add),
        backgroundColor: Colors.yellow,
        foregroundColor: inC,
        mini: true,
      ),
    );
  }

  void _inColorChange() {
    setState(() {
      inC = Colors.red;
    });
  }
}

class MiddleContainer extends StatefulWidget {
  @override
  State<MiddleContainer> createState() => _MiddleContainer();
}

class _MiddleContainer extends State<MiddleContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          color: Colors.green,
          child: Center(
            child: Text('middlew')
          )
        )
      ),
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

class HorizontalContainer extends StatefulWidget {
  @override
  State<HorizontalContainer> createState() => _HorizontalContainer();
}

class _HorizontalContainer extends State<HorizontalContainer> {
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

class HorizontalItem extends StatefulWidget {
  HorizontalItem(this._text, this._color);
  String _text;
  Color _color;
  @override
  State<HorizontalItem> createState() => _HorizontalItem(_text, _color);
}

class _HorizontalItem extends State<HorizontalItem> {
  _HorizontalItem(this._text, this._color);
  String _text;
  final Color _color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      margin: EdgeInsets.all(25),
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            color: _color
          ),
          child: Center(
           child: Text(_text)
          ),
        ),
        onTap: _changeText,
      )
    );
  }
  void _changeText() {
    setState(() {
      if(this._text == 'clicked') {
        this._text = 'once more';
      }
      else this._text = 'clicked';
    });
  }
}
