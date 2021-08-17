import 'package:flutter/material.dart';

class SearchTextResult extends StatefulWidget {
  final String searchText;
  SearchTextResult({required this.searchText});

  @override
  State<SearchTextResult> createState() => _SearchTextResult(searchText: searchText);
}
class _SearchTextResult extends State<SearchTextResult> {
  String searchText;
  _SearchTextResult({required this.searchText});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text(searchText),
      )
    );
  }
}