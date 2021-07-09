import 'package:flutter/material.dart';
import 'navView/navItemView1.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyNav(),
    );
  }
}

class MyNav extends StatefulWidget {
  @override
  State<MyNav> createState() => _MyNav();
}

class _MyNav extends State<MyNav> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('이건모임?'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (int index){
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: 'first',
            icon: Icon(Icons.favorite),
          ),
          BottomNavigationBarItem(
            label: 'second',
            icon: Icon(Icons.favorite),
          ),
          BottomNavigationBarItem(
            label: 'third',
            icon: Icon(Icons.favorite),
          ),
          BottomNavigationBarItem(
            label: 'fourth',
            icon: Icon(Icons.favorite),
          )
        ],
      ),
      body: Center(
        child: _navItemView.elementAt(_selectedIndex),
      ),
    );
  }

  // navigation items view
  List<Widget> _navItemView = <Widget>[
    NavItemView1(),
    NavItemView1(),
    NavItemView1(),
    NavItemView1(),
  ];
}
