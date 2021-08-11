import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_flutter_source/containerCollection.dart';
import 'package:my_flutter_source/functionCollection.dart';

class ProfileSetupView extends StatefulWidget {
  @override
  State<ProfileSetupView> createState() => _ProfileSetupView();
}
class _ProfileSetupView extends State<ProfileSetupView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LoginViewAppBar(),
      body: GestureDetector(
        onTap: () => {},
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 21),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: 24),
                  Text('사진과 닉네임을 등록해주세요'),
                  SizedBox(height: 24),
                  Center(
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: const Color(0xffebebeb)
                      ),
                      child: Image.asset('asset/image/profile.png'),
                    )
                  ),
                  SizedBox(height: 20),
                  Text('닉네임', style: textStyle(weight: 700, size: 14.0), textAlign: TextAlign.left,)
                ],
              ),
              Positioned(
                child: Container(
                  child: SvgPicture.asset('asset/image/icoCamera.svg'),
                )
              )
            ],
          )
        )
      )
    );
  }
}