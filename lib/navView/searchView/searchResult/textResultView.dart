import 'package:flutter/material.dart';
import 'package:my_flutter_source/containerCollection.dart';
import 'resultItemContainer.dart';

class TextResultView extends StatefulWidget {
  final String _text;
  TextResultView(this._text);

  @override
  State<TextResultView> createState() => _TextResultView(_text);
}
class _TextResultView extends State<TextResultView> {
  String _text;
  _TextResultView(this._text);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainViewAppBar(title: _text),
      body: ResultItemContainer(),
    );
  }
}