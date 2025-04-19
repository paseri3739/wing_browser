import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/web_view_config.dart'; // 設定クラスをインポート
import '../../domain/web_view_model.dart';

class WebViewHomePage extends ConsumerWidget {
  const WebViewHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ドメイン層から設定情報を取得
    final config = ref.watch(webViewConfigProvider);
    // providerからNotifierを取得
    final webViewNotifier = ref.read(webViewProvider.notifier);

    // InAppWebViewに渡すPullToRefreshControllerをbuild内で生成
    final pullToRefreshController = PullToRefreshController(
      settings: config.pullToRefreshSettings,
      onRefresh: () async {
        // computed provider を利用して、非nullなWebViewStateを直接取得（初期化前は例外）
        final stateData = ref.read(webViewStateProvider);
        stateData.webViewController.reload();
      },
    );

    return InAppWebView(
      // 設定情報を利用して初期URLと設定を渡す
      initialUrlRequest: URLRequest(url: WebUri(config.initialUrl)),
      initialSettings: config.settings,
      pullToRefreshController: pullToRefreshController,
      onWebViewCreated: (controller) {
        // providerの非同期初期化（状態がloadingの場合のみ更新）
        webViewNotifier.onWebViewCreated(
          controller,
          pullToRefreshController: pullToRefreshController,
        );
      },
      onLoadStop: (controller, url) {
        pullToRefreshController.endRefreshing();
        if (url != null) {
          webViewNotifier.update(url: WebUri(url.toString()));
        }
      },
      onReceivedError: (controller, request, error) {
        debugPrint('WebViewError code=${error.type} description=${error.description}');
        pullToRefreshController.endRefreshing();
      },
      onProgressChanged: (controller, progressPercent) {
        final normalizedProgress = progressPercent / 100.0;
        webViewNotifier.update(
          loadingProgress: LoadingProgress(normalizedProgress),
        );

        if (progressPercent == 100) {
          pullToRefreshController.endRefreshing();
          // 描画前に値がリセットされ、連動してAppBarのプログレスもリセットされる
          webViewNotifier.resetProgress();
        }
      },
      shouldOverrideUrlLoading: (controller, action) async {
        return NavigationActionPolicy.ALLOW;
      },
      onReceivedServerTrustAuthRequest: (controller, challenge) async {
        return ServerTrustAuthResponse(
          action: ServerTrustAuthResponseAction.PROCEED,
        );
      },
    );
  }
}
