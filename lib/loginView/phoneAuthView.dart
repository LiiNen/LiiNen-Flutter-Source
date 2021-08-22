import 'package:flutter/material.dart';
import 'package:my_flutter_source/loginView/profileSetupView.dart';
import 'package:my_flutter_source/main.dart';
import 'package:my_flutter_source/containerCollection.dart';

class PhoneAuthView extends StatefulWidget {
  @override
  State<PhoneAuthView> createState() => _PhoneAuthView();
}
class _PhoneAuthView extends State<PhoneAuthView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: LoginViewAppBar(),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 21 * responsiveScale),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: [

            ],
          )
        )
      )
    );
  }

  void _nextStep() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileSetupView()));
  }
}