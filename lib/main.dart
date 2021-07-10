import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'navView/navItemView1.dart';
import 'navView/navItemView2.dart';
import 'navView/navItemView3.dart';
import 'navView/navItemView4.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginView();
}
class _LoginView extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('cannot go back'),
          onLongPress: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyNav())
            );
          },
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyNav())
            );
          },
        )
      )
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
            showToast('index $index');
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
    NavItemView2(),
    NavItemView3(),
    NavItemView4(),
  ];
}

void showToast(String message){
  Fluttertoast.showToast(msg: message,
    gravity: ToastGravity.BOTTOM
  );
}