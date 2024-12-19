import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// State class for WebView state management
class WebViewState {
  final double progress;
  final String url;

  WebViewState({this.progress = 0.0, this.url = "https://www.google.com"});

  WebViewState copyWith({double? progress, String? url}) {
    return WebViewState(
      progress: progress ?? this.progress,
      url: url ?? this.url,
    );
  }
}

/// StateNotifier to manage WebViewState
class WebViewNotifier extends StateNotifier<WebViewState> {
  WebViewNotifier() : super(WebViewState());

  void setProgress(double progress) {
    state = state.copyWith(progress: progress);
  }

  void setUrl(String url) {
    state = state.copyWith(url: url);
  }

  void resetProgress() {
    state = state.copyWith(progress: 0.0);
  }
}

/// Provider for WebViewNotifier
final webViewProvider = StateNotifierProvider<WebViewNotifier, WebViewState>((ref) {
  return WebViewNotifier();
});

class WebViewHomePage extends ConsumerStatefulWidget {
  const WebViewHomePage({super.key});

  @override
  ConsumerState<WebViewHomePage> createState() => _WebViewHomePageState();
}

class _WebViewHomePageState extends ConsumerState<WebViewHomePage> {
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
    final webViewNotifier = ref.read(webViewProvider.notifier);

    return InAppWebView(
      initialUrlRequest: URLRequest(url: WebUri(_initialUrl)),
      initialSettings: _settings,
      pullToRefreshController: _pullToRefreshController,
      onWebViewCreated: (controller) {
        _webViewController = controller;
      },
      onLoadStop: (controller, url) {
        _pullToRefreshController.endRefreshing();
        if (url != null) {
          webViewNotifier.setUrl(url.toString());
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
