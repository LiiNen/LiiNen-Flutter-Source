import 'package:flutter/material.dart';
import 'package:my_flutter_source/containerCollection.dart';

class DeleteAccountView extends StatefulWidget {
  @override
  State<DeleteAccountView> createState() => _DeleteAccountView();
}
class _DeleteAccountView extends State<DeleteAccountView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainViewAppBar(title: '계정탈퇴', back: true),
    );
  }
}