import 'package:flutter/material.dart';
import 'package:my_flutter_source/containerCollection.dart';

class AlarmView extends StatefulWidget {
  @override
  State<AlarmView> createState() => _AlarmView();
}
class _AlarmView extends State<AlarmView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainViewAppBar(title: '알림', back: false),
      body: SingleChildScrollView(
        child: Column(
          children: [],
        )
      ),
    );
  }
}
