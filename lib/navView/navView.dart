import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'homeView/homeView.dart';
import 'searchView/searchView.dart';
import 'clubView/clubView.dart';
import 'alarmView/alarmView.dart';
import 'profileView/profileView.dart';

import 'package:my_flutter_source/functionCollection.dart';

class NavView extends StatefulWidget {
  @override
  State<NavView> createState() => _NavView();
}
class _NavView extends State<NavView> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitDialog(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor:Colors.white,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xff0958c5),
          unselectedItemColor: Color(0xffd1d5d9),
          selectedFontSize: 10,
          unselectedFontSize: 10,
          onTap: (int index){
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(label: '홈', icon: Icon(Icons.home)),
            BottomNavigationBarItem(label: '찾아보기', icon: Icon(Icons.search)),
            BottomNavigationBarItem(label: '내 모임', icon: Icon(Icons.people_alt_sharp)),
            BottomNavigationBarItem(label: '알림', icon: Icon(Icons.notifications_none)),
            BottomNavigationBarItem(label: '더 보기', icon: Icon(Icons.more_horiz))
          ],
        ),
        body: Center(
          child: _navItemView.elementAt(_selectedIndex),
        ),
      )
    );
  }

  // navigation items view
  List<Widget> _navItemView = <Widget>[
    HomeView(),
    SearchView(),
    ClubView(),
    AlarmView(),
    ProfileView(),
  ];
}