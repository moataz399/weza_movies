import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WatchingScreen extends StatelessWidget {

  final url ;

  WatchingScreen({this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebView(
        initialUrl: url,
      ),
    );
  }
}