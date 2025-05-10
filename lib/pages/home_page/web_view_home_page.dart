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
        await ref.read(webViewProvider.notifier).refreshMeta();
        ref.read(webViewProvider.notifier).resetProgress();
        await ref.read(webViewProvider.notifier).reload();
      },
    );

    return InAppWebView(
      // 設定情報を利用して初期URLと設定を渡す
      initialUrlRequest: URLRequest(url: config.initialUrl),
      initialSettings: config.settings,
      pullToRefreshController: pullToRefreshController,

      // 状態を初期化
      onWebViewCreated: (controller) => ref
          .read(webViewProvider.notifier)
          .onWebViewCreated(controller, pullToRefreshController: pullToRefreshController),

      onLoadStart: (_, __) => ref.read(webViewProvider.notifier).update(loadingProgress: const LoadingProgress(0.1)),

      onLoadStop: (_, __) async {
        await ref.read(webViewProvider.notifier).refreshMeta();
        ref.read(webViewProvider.notifier).resetProgress();
      },

      onTitleChanged: (_, __) => ref.read(webViewProvider.notifier).refreshMeta(),

      onReceivedError: (controller, request, error) {
        debugPrint('🛑 WebViewError');
        debugPrint('  ▶️ URL: ${request.url}');
        debugPrint('  ▶️ Method: ${request.method}');
        debugPrint('  ▶️ Headers: ${request.headers}');
        debugPrint('  ▶️ Is main frame: ${request.isForMainFrame}');
        debugPrint('  ▶️ Error type: ${error.type}');
        debugPrint('  ▶️ Description: ${error.description}');
        pullToRefreshController.endRefreshing();
        controller.stopLoading();
        webViewNotifier.update(
          loadingProgress: LoadingProgress(0.0),
        );
      },
      onReceivedHttpError: (controller, request, error) {
        debugPrint('🛑 WebViewHttpError');
        debugPrint('  ▶️ URL: ${request.url}');
        debugPrint('  ▶️ Method: ${request.method}');
        debugPrint('  ▶️ Headers: ${request.headers}');
        debugPrint('  ▶️ Is main frame: ${request.isForMainFrame}');
        debugPrint('  ▶️ Status code: ${error.statusCode}');
        debugPrint('  ▶️ Description: ${error.reasonPhrase}');
        pullToRefreshController.endRefreshing();
        controller.stopLoading();
        webViewNotifier.update(
          loadingProgress: LoadingProgress(0.0),
        );
      },

      onProgressChanged: (_, progress) {
        ref.read(webViewProvider.notifier).update(loadingProgress: LoadingProgress(progress / 100));
        if (progress == 100) {
          pullToRefreshController.endRefreshing();
          // 描画前に値がリセットされ、連動してAppBarのプログレスもリセットされる
          webViewNotifier.resetProgress();
        }
      },

      // iOSのSSL関係で必要らしい
      shouldOverrideUrlLoading: (controller, action) async {
        return NavigationActionPolicy.ALLOW;
      },
      onReceivedServerTrustAuthRequest: (controller, challenge) async {
        debugPrint('🧾 ServerTrustAuthRequest: ${challenge.toJson()}');
        return ServerTrustAuthResponse(
          action: ServerTrustAuthResponseAction.PROCEED,
        );
      },
    );
  }
}
