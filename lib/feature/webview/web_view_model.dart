import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// State class for WebView state management
final class WebViewState {
  final WebUri? url;
  final String? title;
  final double progress;
  final InAppWebViewController? webViewController;
  final PullToRefreshController? pullToRefreshController;

  WebViewState({
    this.url,
    this.title,
    this.progress = 0.0,
    this.webViewController,
    this.pullToRefreshController,
  });

  WebViewState copyWith({
    WebUri? url,
    String? title,
    double? progress,
    InAppWebViewController? webViewController,
    PullToRefreshController? pullToRefreshController,
  }) {
    return WebViewState(
      url: url ?? this.url,
      title: title ?? this.title,
      progress: progress ?? this.progress,
      webViewController: webViewController ?? this.webViewController,
      pullToRefreshController: pullToRefreshController ?? this.pullToRefreshController,
    );
  }
}

/// StateNotifier to manage WebViewState
final class WebViewNotifier extends StateNotifier<WebViewState> {
  WebViewNotifier() : super(WebViewState());

  void setUrl(WebUri url) {
    state = state.copyWith(url: url);
  }

  void setTitle(String title) {
    state = state.copyWith(title: title);
  }

  void setProgress(double progress) {
    state = state.copyWith(progress: progress);
  }

  void setWebViewController(InAppWebViewController webViewController) {
    state = state.copyWith(webViewController: webViewController);
  }

  void setPullToRefreshController(PullToRefreshController pullToRefreshController) {
    state = state.copyWith(pullToRefreshController: pullToRefreshController);
  }

  void resetProgress() {
    state = state.copyWith(progress: 0.0);
  }
}

/// Provider for WebViewNotifier
final webViewProvider = StateNotifierProvider<WebViewNotifier, WebViewState>((ref) {
  return WebViewNotifier();
});
