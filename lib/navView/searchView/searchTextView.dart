import 'package:flutter/material.dart';
import 'package:my_flutter_source/containerCollection.dart';

class SearchTextView extends StatefulWidget {
  @override
  State<SearchTextView> createState() => _SearchTextView();
}
class _SearchTextView extends State<SearchTextView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainViewAppBar(title: '탐색', back: true),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
      )
    );
  }
}