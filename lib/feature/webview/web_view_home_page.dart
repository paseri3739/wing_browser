import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'domain/web_view_model.dart';

class WebViewHomePage extends ConsumerStatefulWidget {
  const WebViewHomePage({super.key});

  @override
  ConsumerState<WebViewHomePage> createState() => _WebViewHomePageState();
}

// TODO: 状態管理、ビジネスロジックをドメイン層に移管する

class _WebViewHomePageState extends ConsumerState<WebViewHomePage> {
  final InAppWebViewSettings _settings = InAppWebViewSettings(isInspectable: kDebugMode); // グローバル変数
  final PullToRefreshSettings _pullToRefreshSettings = PullToRefreshSettings(color: Colors.blue);
  final String _initialUrl = "https://www.google.com";

  @override
  Widget build(BuildContext context) {
    // providerからNotifierを取得
    final webViewNotifier = ref.read(webViewProvider.notifier);

    // InAppWebViewに渡すPullToRefreshControllerをbuild内で生成
    final pullToRefreshController = PullToRefreshController(
      settings: _pullToRefreshSettings,
      onRefresh: () async {
        // providerの状態からwebViewControllerを取得（nullの場合は何もしない）
        final stateData = ref.read(webViewProvider).maybeWhen(
              data: (data) => data,
              orElse: () => null,
            );
        if (stateData != null) {
          final controller = stateData.webViewController;
          // if (defaultTargetPlatform == TargetPlatform.android) {
          controller.reload();
          // } else if (defaultTargetPlatform == TargetPlatform.iOS) {
          //   final url = await controller.getUrl();
          //   if (url != null) {
          //     controller.loadUrl(urlRequest: URLRequest(url: url));
          //   }
          // }
        }
      },
    );

    return InAppWebView(
      initialUrlRequest: URLRequest(url: WebUri(_initialUrl)),
      initialSettings: _settings,
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
        pullToRefreshController.endRefreshing();
      },
      onProgressChanged: (controller, progressPercent) {
        final normalizedProgress = progressPercent / 100.0;
        webViewNotifier.update(progress: normalizedProgress);

        if (progressPercent == 100) {
          pullToRefreshController.endRefreshing();
          // 描画前に値がリセットされ、連動してAppBarのプログレスもリセットされる
          webViewNotifier.resetProgress();
        }
      },
    );
  }
}
