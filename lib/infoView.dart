import 'package:flutter/material.dart';

class InfoView extends StatefulWidget {
  final String _infoSrc;
  InfoView(this._infoSrc);

  @override
  State<InfoView> createState() => _InfoView(_infoSrc);
}
class _InfoView extends State<InfoView> {
  final String _infoSrc;
  _InfoView(this._infoSrc);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_infoSrc)),
    );
  }
}