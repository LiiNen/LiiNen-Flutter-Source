import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'homeView/homeView.dart';
import 'clubView/clubView.dart';
import 'searchView/searchView.dart';
import 'profileView/profileView.dart';


class NavView extends StatefulWidget {
  @override
  State<NavView> createState() => _NavView();
}
class _NavView extends State<NavView> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          BottomNavigationBarItem(label: '스토리/피드', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: '배너', icon: Icon(Icons.favorite)),
          BottomNavigationBarItem(label: '제목없음', icon: Icon(Icons.search)),
          BottomNavigationBarItem(label: '개인설정', icon: Icon(Icons.account_circle))
        ],
      ),
      body: Center(
        child: _navItemView.elementAt(_selectedIndex),
      ),
    );
  }

  // navigation items view
  List<Widget> _navItemView = <Widget>[
    HomeView(),
    SearchView(),
    ClubView(),
    ProfileView(),
  ];
}

void showToast(String message){
  Fluttertoast.showToast(msg: message,
      gravity: ToastGravity.BOTTOM
  );
}