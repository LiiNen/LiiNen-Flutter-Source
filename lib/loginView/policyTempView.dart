import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PolicyTempView extends StatefulWidget {
  @override
  State<PolicyTempView> createState() => _PolicyTempView();
}
class _PolicyTempView extends State<PolicyTempView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea (
        child: WebView(
          initialUrl: 'https://www.github.com/LiiNen',
          javascriptMode: JavascriptMode.unrestricted,
        )
      )
    );
  }
}