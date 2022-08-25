import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late WebViewController _webViewController;
  late WebViewPlatformController _webViewPlatformController;

  Future<String?> currentUrl() {
    return _webViewPlatformController.currentUrl();
  }

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) {
      WebView.platform = AndroidWebView();
    } else if (Platform.isIOS) {
      WebView.platform = CupertinoWebView();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Wing Browser"),
        actions: [
          IconButton(
              onPressed: () async{
                if (await _webViewController.canGoBack()) {
                  _webViewController.goBack();
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("履歴がありません"))
                  );
                }
              },
              icon: const Icon(
                  Icons.arrow_back
              )
          ),

          IconButton(
              onPressed: () async{
                if (await _webViewController.canGoForward()) {
                  _webViewController.goForward();
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("履歴がありません"))
                  );
                }
              },
              icon: const Icon(
                  Icons.arrow_forward
              )
          ),

          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _webViewController.reload(),
          ),

        ], //actions
      ),

      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add), onPressed: () {},),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(icon: Icon(Icons.menu), onPressed: () {},),
            IconButton(icon: Icon(Icons.search), onPressed: () {},),
          ],
        ),
      ),

      body: Center(
        child: WebView(
          initialUrl: "https://www.google.com" ,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController controller) {
            // We are getting an instance of the controller in the callback
            // So we take it assign it our late variable value
            // コレがないとcontrollerが機能しない。
            _webViewController = controller ;
          },
        ),
      ),
    );
  }
}
