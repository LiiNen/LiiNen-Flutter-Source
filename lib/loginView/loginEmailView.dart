import 'package:flutter/material.dart';

class LoginEmailView extends StatefulWidget {
  @override
  State<LoginEmailView> createState() => _LoginEmailView();
}
class _LoginEmailView extends State<LoginEmailView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.only(left: 21),
          icon: Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: () {Navigator.pop(context);},
        ),
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: const Color(0xffffffff)
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 21),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('이메일 로그인',
                    style: TextStyle(fontWeight: FontWeight.w700, fontFamily: "AppleSDGothicNeo",fontStyle:  FontStyle.normal, fontSize: 20.0),
                    textAlign: TextAlign.left,
                  ),
                  Text('이메일', style: _itemTextStyle(), textAlign: TextAlign.left,),
                  TextField(
                    controller: emailController,
                    autofocus: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '이메일',
                    ),
                    onChanged: (value) {setState(() {});},
                  ),
                  Text('비밀번호', style: _itemTextStyle(), textAlign: TextAlign.left,),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    autofocus: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '비밀번호',
                    ),
                    onChanged: (value) {setState(() {});},
                  ),
                  Text('아이디/비밀번호 찾기'),
                  Container(
                      height: 52,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(4)
                          ),
                          color: emailController.text != '' && passwordController.text != '' ? Color(0xff0958c5) : Color(0xffd1d5d9)
                      ),
                      child: Center(child: Text('로그인', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontFamily: "AppleSDGothicNeo", fontStyle:  FontStyle.normal, fontSize: 16.0)))
                  ),
                ]
              ),
              Positioned(
                bottom: 36,
                child: Container(
                  width: MediaQuery.of(context).size.width - 42,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('아직 계정이 없으신가요?', style: TextStyle(fontWeight: FontWeight.w400, fontFamily: "AppleSDGothicNeo", fontStyle:  FontStyle.normal, fontSize: 16.0)),
                        Container(
                            child: Text('회원가입', style: TextStyle(fontWeight: FontWeight.w600, fontFamily: "AppleSDGothicNeo", fontStyle:  FontStyle.normal, fontSize: 16.0))
                        )
                      ]
                    )
                  )
                )
              )
            ]
          )
        )
      )
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  TextStyle _itemTextStyle() {
    return TextStyle(
      fontWeight: FontWeight.w700,
      fontFamily: "AppleSDGothicNeo",
      fontStyle:  FontStyle.normal,
      fontSize: 14.0
    );
  }
  Container _inputBox() {
    return Container(
      height: 46,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
              Radius.circular(2)
          ),
          border: Border.all(
              color: const Color(0xffe4e4e4),
              width: 1
          )
      )
    );
  }
}
