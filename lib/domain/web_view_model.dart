import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// プリミティブをやめる
final class WebViewTabTitle {
  final String title;
  const WebViewTabTitle(this.title);
}

final class LoadingProgress {
  final double progress;
  bool get isLoading => progress != 0.0;
  const LoadingProgress(this.progress);
}

// WebViewの状態クラス
final class WebViewModel {
  final WebUri? url;
  final WebViewTabTitle currentTabTitle;
  final String? faviconUrl;
  final LoadingProgress loadingProgress;
  final InAppWebViewController webViewController;
  final PullToRefreshController pullToRefreshController;

  const WebViewModel({
    required this.url,
    required this.currentTabTitle,
    required this.faviconUrl,
    required this.loadingProgress,
    required this.webViewController,
    required this.pullToRefreshController,
  });

  bool get isLoading => loadingProgress.isLoading;

  WebViewModel copyWith({
    WebUri? url,
    WebViewTabTitle? currentTabTitle,
    String? faviconUrl,
    LoadingProgress? loadingProgress,
    InAppWebViewController? webViewController,
    PullToRefreshController? pullToRefreshController,
  }) {
    return WebViewModel(
      url: url ?? this.url,
      currentTabTitle: currentTabTitle ?? this.currentTabTitle,
      faviconUrl: faviconUrl ?? this.faviconUrl,
      loadingProgress: loadingProgress ?? this.loadingProgress,
      webViewController: webViewController ?? this.webViewController,
      pullToRefreshController: pullToRefreshController ?? this.pullToRefreshController,
    );
  }
}

// 非同期状態を管理するStateNotifier
final class WebViewNotifier extends StateNotifier<AsyncValue<WebViewModel>> {
  WebViewNotifier() : super(const AsyncValue.loading());

  // InAppWebView.onWebViewCreated で呼び出す
  void onWebViewCreated(
    InAppWebViewController controller, {
    required PullToRefreshController pullToRefreshController,
  }) {
    state = AsyncValue.data(
      WebViewModel(
        url: null,
        currentTabTitle: const WebViewTabTitle(''),
        faviconUrl: null,
        loadingProgress: const LoadingProgress(0.0),
        webViewController: controller,
        pullToRefreshController: pullToRefreshController,
      ),
    );
  }

  // 汎用 update
  void update({
    WebUri? url,
    WebViewTabTitle? title,
    String? faviconUrl,
    LoadingProgress? loadingProgress,
  }) {
    state.whenData((m) {
      state = AsyncValue.data(
        m.copyWith(
          url: url,
          currentTabTitle: title,
          faviconUrl: faviconUrl,
          loadingProgress: loadingProgress,
        ),
      );
    });
  }

  // タイトル・ファビコン・URL を一括再取得
  Future<void> refreshMeta() async {
    final model = _require();
    final results = await Future.wait([
      model.webViewController.getTitle(),
      model.webViewController.getFavicons(),
      model.webViewController.getUrl(),
    ]);

    final title = (results[0] as String?) ?? 'No Title';
    final favicons = results[1] as List<Favicon>? ?? const [];
    final faviconUrl = favicons.isNotEmpty ? favicons.first.url.toString() : null;
    final uri = results[2] as WebUri?;

    update(
      url: uri,
      title: WebViewTabTitle(title),
      faviconUrl: faviconUrl,
    );
  }

  Future<void> reload() async {
    final model = _require();
    await model.webViewController.reload();
  }

  // 進捗リセット
  void resetProgress() => update(loadingProgress: const LoadingProgress(0.0));

  WebViewModel _require() => state.value ?? (throw StateError('WebView not ready'));
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
