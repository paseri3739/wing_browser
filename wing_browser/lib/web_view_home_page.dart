import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewHomePage extends StatefulWidget {
  const WebViewHomePage({super.key});

  @override
  State<WebViewHomePage> createState() => _WebViewHomePageState();
}

class _WebViewHomePageState extends State<WebViewHomePage> {
  late InAppWebViewController _webViewController;
  final initUrl = WebUri("https://www.google.com");
  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: URLRequest(url: initUrl),
      onWebViewCreated: (InAppWebViewController controller) {
        _webViewController = controller;
      },
    );
  }
}
