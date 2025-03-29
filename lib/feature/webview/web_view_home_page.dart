import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wing_browser/feature/webview/web_view_model.dart';

class WebViewHomePage extends ConsumerStatefulWidget {
  const WebViewHomePage({super.key});

  @override
  ConsumerState<WebViewHomePage> createState() => _WebViewHomePageState();
}

class _WebViewHomePageState extends ConsumerState<WebViewHomePage> {
  static const int _FINISHED = 100;
  final InAppWebViewSettings _settings = InAppWebViewSettings(isInspectable: kDebugMode); // グローバル変数
  final PullToRefreshSettings _pullToRefreshSettings = PullToRefreshSettings(
    color: Colors.blue,
  );
  final String _initialUrl = "https://www.google.com";
  late final InAppWebViewController _webViewController;
  late final PullToRefreshController _pullToRefreshController;

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
    // readは描画をトリガーしないため、Notifierを取得するために使用する
    final webViewNotifier = ref.read(webViewProvider.notifier);

    return InAppWebView(
      initialUrlRequest: URLRequest(url: WebUri(_initialUrl)),
      initialSettings: _settings,
      pullToRefreshController: _pullToRefreshController,
      onWebViewCreated: (controller) {
        _webViewController = controller;
        webViewNotifier.setWebViewController(controller);
      },
      onLoadStop: (controller, url) {
        _pullToRefreshController.endRefreshing();
        if (url != null) {
          webViewNotifier.setUrl(WebUri(url.toString()));
        }
      },
      onReceivedError: (controller, request, error) {
        _pullToRefreshController.endRefreshing();
      },
      onProgressChanged: (controller, progress) {
        final normalizedProgress = progress / 100.0;
        webViewNotifier.setProgress(normalizedProgress);

        if (progress == _FINISHED) {
          _pullToRefreshController.endRefreshing();
          // 描画前に値がリセットされ、連動してAppBarのプログレスもリセットされる
          webViewNotifier.resetProgress();
        }
      },
    );
  }
}
