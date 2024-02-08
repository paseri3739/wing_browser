import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WebViewHomePage extends StatefulWidget {
  const WebViewHomePage({super.key});

  @override
  State<WebViewHomePage> createState() => _WebViewHomePageState();
}

final initialUrlProvider =
    StateProvider<String>((ref) => "https://www.google.com");
final pullToRefreshControllerProvider =
    StateProvider.autoDispose<PullToRefreshController?>((ref) => null);
final webViewControllerProvider = StateProvider((ref) => null);

class _WebViewHomePageState extends State<WebViewHomePage> {
  late InAppWebViewController webViewController;
  InAppWebViewSettings settings =
      InAppWebViewSettings(isInspectable: kDebugMode);
  late PullToRefreshController pullToRefreshController;
  PullToRefreshSettings pullToRefreshSettings = PullToRefreshSettings(
    color: Colors.blue,
  );
  double progress = 0.0;
  bool pullToRefreshEnabled = true;
  String initialUrl = "https://www.google.com";

  @override
  void initState() {
    super.initState();

    pullToRefreshController = PullToRefreshController(
      settings: pullToRefreshSettings,
      onRefresh: () async {
        if (defaultTargetPlatform == TargetPlatform.android) {
          webViewController.reload();
        } else if (defaultTargetPlatform == TargetPlatform.iOS) {
          webViewController.loadUrl(
              urlRequest: URLRequest(url: await webViewController.getUrl()));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: URLRequest(url: WebUri(initialUrl)),
      initialSettings: settings,
      pullToRefreshController: pullToRefreshController,
      onLoadStop: (controller, url) {
        pullToRefreshController.endRefreshing();
      },
      onReceivedError: (controller, request, error) {
        pullToRefreshController.endRefreshing();
      },
      onProgressChanged: (controller, progress) {
        if (progress == 100) {
          pullToRefreshController.endRefreshing();
        }
      },
    );
  }
}
