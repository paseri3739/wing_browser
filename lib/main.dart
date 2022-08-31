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
      title: 'Wing Browser',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Wing Browser'),
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

  late WebViewController webviewController;
  double progress = 0;
  bool loading = true;

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
      resizeToAvoidBottomInset: false, //do not show float button when keyboard appear

      appBar: AppBar(
        title: const Text("Wing Browser"),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: Container(
          height: 60,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(icon: const Icon(Icons.menu),
                    onPressed: () {},),
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () => webviewController.reload(),
                  ),
                ],
              ), //left_side
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () async{
                        if (await webviewController.canGoBack()) {
                          webviewController.goBack();
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
                        if (await webviewController.canGoForward()) {
                          webviewController.goForward();
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
                ],
              ), //right_side
            ],
          ),
        ),
      ),

      body: Column(
        children: [
          loading == true ? SizedBox( //三項演算子
            height: 5,
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.black12,
              color: Colors.red,
            ),
          ): SizedBox(),
          Expanded(
            child: WebView(
                initialUrl: "https://www.google.com" ,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController controller) {
                  // We are getting an instance of the controller in the callback
                  // So we take it assign it our late variable value
                  // コレがないとcontrollerが機能しない。
                  webviewController = controller ;
                },
                onProgress: (progress)  =>
                    setState( () => this.progress = progress / 100 ),
                onPageStarted: (finish) =>
                    setState( () => loading = true ),
                onPageFinished: (finish) =>
                    setState( () => loading = false ),
            ),
          ),
        ],
      ),
    );
  }
}