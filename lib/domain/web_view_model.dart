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
final class WebViewModel {
  final WebUri currentUrl;
  final WebViewTabTitle currentTabTitle;
  final LoadingProgress loadingProgress;
  final InAppWebViewController webViewController;
  final PullToRefreshController pullToRefreshController;

  WebViewModel({
    required this.currentUrl,
    required this.currentTabTitle,
    required this.loadingProgress,
    required this.webViewController,
    required this.pullToRefreshController,
  });

  // progress が 0.0 でない場合は true を返す getter を追加
  bool get isLoading => loadingProgress.progress != 0.0;

  WebViewModel copyWith({
    WebUri? url,
    WebViewTabTitle? title,
    LoadingProgress? loadingProgress,
    InAppWebViewController? webViewController,
    PullToRefreshController? pullToRefreshController,
  }) {
    return WebViewModel(
      currentUrl: url ?? currentUrl,
      currentTabTitle: title ?? currentTabTitle,
      loadingProgress: loadingProgress ?? this.loadingProgress,
      webViewController: webViewController ?? this.webViewController,
      pullToRefreshController: pullToRefreshController ?? this.pullToRefreshController,
    );
  }
}

// 非同期状態を管理するStateNotifier
final class WebViewNotifier extends StateNotifier<AsyncValue<WebViewModel>> {
  WebViewNotifier() : super(const AsyncValue.loading());

  // InAppWebViewのonWebViewCreatedで呼び出す（pullToRefreshControllerも受け取る）
  void onWebViewCreated(
    InAppWebViewController controller, {
    required PullToRefreshController pullToRefreshController,
  }) {
    // 初期値（必要に応じて調整）
    final initialUrl = WebUri("https://www.google.co.jp"); // FIXME: 設定がモデルと重複してる
    const initialTitle = WebViewTabTitle("Google");

    final newState = WebViewModel(
      currentUrl: initialUrl,
      currentTabTitle: initialTitle,
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
final webViewProvider = StateNotifierProvider<WebViewNotifier, AsyncValue<WebViewModel>>((ref) {
  return WebViewNotifier();
});

/// 非同期状態を隠蔽し、初期化済み WebViewState を返す（初期化前は例外）
final webViewStateProvider = Provider<WebViewModel>((ref) {
  final asyncState = ref.watch(webViewProvider);
  return asyncState.when(
    data: (data) => data,
    loading: () => throw Exception('WebViewState is not initialized yet'),
    error: (error, stack) => throw Exception('WebViewState error: $error'),
  );
});
