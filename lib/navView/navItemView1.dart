import 'package:flutter/material.dart';

void main() => runApp(NavItemView1());

class NavItemView1 extends StatefulWidget {
  @override
  State<NavItemView1> createState() => _NavItemView1();
}

class _NavItemView1 extends State<NavItemView1> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Text('hel')
      ),
    );
  }
}
