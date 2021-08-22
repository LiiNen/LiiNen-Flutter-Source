import 'package:flutter/material.dart';

import 'package:my_flutter_source/containerCollection.dart';
import 'package:my_flutter_source/main.dart';

class ProfileView extends StatefulWidget {
  @override
  State<ProfileView> createState() => _ProfileView();
}
class _ProfileView extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainViewAppBar(title: '더보기', back: false),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 21 * responsiveScale),
        child: Column(

        )
      )
    );
  }
}