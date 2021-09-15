import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

late WebViewController _controller; //late is required
Future<String?> currentUrl() {
  return _controller.currentUrl();
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {

  final String initUrl = "https://www.google.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text("current"),
      ),
      body: WebView(
        initialUrl: initUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

