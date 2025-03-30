import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// WebViewの状態クラス
final class WebViewState {
  final WebUri url;
  final String title;
  final double progress;
  final InAppWebViewController webViewController;
  final PullToRefreshController pullToRefreshController;

  WebViewState({
    required this.url,
    required this.title,
    this.progress = 0.0,
    required this.webViewController,
    required this.pullToRefreshController,
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

// 非同期状態を管理するStateNotifier
final class WebViewNotifier extends StateNotifier<AsyncValue<WebViewState>> {
  WebViewNotifier() : super(const AsyncValue.loading());

  // InAppWebViewのonWebViewCreatedで呼び出す（pullToRefreshControllerも受け取る）
  void onWebViewCreated(
    InAppWebViewController controller, {
    required PullToRefreshController pullToRefreshController,
  }) {
    // 初期値（必要に応じて調整）
    final initialUrl = WebUri("https://www.google.com");
    const initialTitle = "Google";

    final newState = WebViewState(
      url: initialUrl,
      title: initialTitle,
      webViewController: controller,
      pullToRefreshController: pullToRefreshController,
    );

    state = AsyncValue.data(newState);
  }

  // 複数の状態更新を1つのメソッドで行う
  void update({
    WebUri? url,
    String? title,
    double? progress,
    InAppWebViewController? webViewController,
    PullToRefreshController? pullToRefreshController,
  }) {
    state.whenData((data) {
      state = AsyncValue.data(data.copyWith(
        url: url,
        title: title,
        progress: progress,
        webViewController: webViewController,
        pullToRefreshController: pullToRefreshController,
      ));
    });
  }

  // 進捗状態のリセット
  void resetProgress() {
    update(progress: 0.0);
  }
}

/// 非同期状態を提供するためのProvider
final webViewProvider = StateNotifierProvider<WebViewNotifier, AsyncValue<WebViewState>>((ref) {
  return WebViewNotifier();
});
