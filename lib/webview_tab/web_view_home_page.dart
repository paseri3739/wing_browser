import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

class WebViewHomePage extends StatefulWidget {
  const WebViewHomePage({super.key});

  @override
  State<WebViewHomePage> createState() => _WebViewHomePageState();
}

// final initialUrlProvider = StateProvider<String>((ref) => "https://www.google.com");
// final pullToRefreshControllerProvider = StateProvider.autoDispose<PullToRefreshController?>((ref) => null);
// final webViewControllerProvider = StateProvider((ref) => null);

class _WebViewHomePageState extends State<WebViewHomePage> {
  static const int _FINISHED = 100;
  late final InAppWebViewController _webViewController;
  final InAppWebViewSettings _settings = InAppWebViewSettings(isInspectable: kDebugMode);
  late final PullToRefreshController _pullToRefreshController;
  final PullToRefreshSettings _pullToRefreshSettings = PullToRefreshSettings(
    color: Colors.blue,
  );
  final String _initialUrl = "https://www.google.com";

  @override
  void initState() {
    super.initState();

    _pullToRefreshController = PullToRefreshController(
      settings: _pullToRefreshSettings,
      onRefresh: () async {
        if (defaultTargetPlatform == TargetPlatform.android) {
          _webViewController.reload();
        } else if (defaultTargetPlatform == TargetPlatform.iOS) {
          _webViewController.loadUrl(urlRequest: URLRequest(url: await _webViewController.getUrl()));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: URLRequest(url: WebUri(_initialUrl)),
      initialSettings: _settings,
      pullToRefreshController: _pullToRefreshController,
      onWebViewCreated: (controller) {
        _webViewController = controller;
      },
      onLoadStop: (controller, url) {
        _pullToRefreshController.endRefreshing();
      },
      onReceivedError: (controller, request, error) {
        _pullToRefreshController.endRefreshing();
      },
      onProgressChanged: (controller, progress) {
        if (progress == _FINISHED) {
          _pullToRefreshController.endRefreshing();
        }
      },
    );
  }
}
