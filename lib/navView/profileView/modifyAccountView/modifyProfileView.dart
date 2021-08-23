import 'package:flutter/material.dart';
import 'package:my_flutter_source/containerCollection.dart';

class ModifyProfileView extends StatefulWidget {
  @override
  State<ModifyProfileView> createState() => _ModifyProfileView();
}
class _ModifyProfileView extends State<ModifyProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainViewAppBar(title: '프로필 편집', back: true),
    );
  }
}