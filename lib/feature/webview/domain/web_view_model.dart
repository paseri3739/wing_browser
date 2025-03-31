import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// プリミティブをやめる
final class WebViewTabTitle {
  final String title;
  const WebViewTabTitle(this.title);
}

final class LoadingProgress {
  final double progress;
  const LoadingProgress(this.progress);
}

// WebViewの状態クラス
final class WebViewState {
  final WebUri url;
  final WebViewTabTitle title;
  final LoadingProgress loadingProgress;
  final InAppWebViewController webViewController;
  final PullToRefreshController pullToRefreshController;

  WebViewState({
    required this.url,
    required this.title,
    required this.loadingProgress,
    required this.webViewController,
    required this.pullToRefreshController,
  });

  WebViewState copyWith({
    WebUri? url,
    WebViewTabTitle? title,
    LoadingProgress? loadingProgress,
    InAppWebViewController? webViewController,
    PullToRefreshController? pullToRefreshController,
  }) {
    return WebViewState(
      url: url ?? this.url,
      title: title ?? this.title,
      loadingProgress: loadingProgress ?? this.loadingProgress,
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
    const initialTitle = WebViewTabTitle("Google");

    final newState = WebViewState(
      url: initialUrl,
      title: initialTitle,
      loadingProgress: LoadingProgress(0.0),
      webViewController: controller,
      pullToRefreshController: pullToRefreshController,
    );

    state = AsyncValue.data(newState);
  }

  // 複数の状態更新を1つのメソッドで行う
  void update({
    WebUri? url,
    WebViewTabTitle? title,
    LoadingProgress? loadingProgress,
    InAppWebViewController? webViewController,
    PullToRefreshController? pullToRefreshController,
  }) {
    state.whenData((data) {
      state = AsyncValue.data(data.copyWith(
        url: url,
        title: title,
        loadingProgress: loadingProgress,
        webViewController: webViewController,
        pullToRefreshController: pullToRefreshController,
      ));
    });
  }

  // 進捗状態のリセット
  void resetProgress() {
    update(loadingProgress: LoadingProgress(0.0));
  }
}

/// 非同期状態を提供するためのProvider
final webViewProvider = StateNotifierProvider<WebViewNotifier, AsyncValue<WebViewState>>((ref) {
  return WebViewNotifier();
});

/// 非同期状態を隠蔽し、初期化済み WebViewState を返す（初期化前は例外）
final webViewStateProvider = Provider<WebViewState>((ref) {
  final asyncState = ref.watch(webViewProvider);
  return asyncState.when(
    data: (data) => data,
    loading: () => throw Exception('WebViewState is not initialized yet'),
    error: (error, stack) => throw Exception('WebViewState error: $error'),
  );
});
