import 'package:flutter/material.dart';

void main() => runApp(NavItemView2());

class NavItemView2 extends StatefulWidget {
  @override
  State<NavItemView2> createState() => _NavItemView2();
}

class _NavItemView2 extends State<NavItemView2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SizedBox(
              height: 200,
              width: 200,
              child: Image.asset('asset/image/sample2.jpeg'),
          ),
      ),
    );
  }
}