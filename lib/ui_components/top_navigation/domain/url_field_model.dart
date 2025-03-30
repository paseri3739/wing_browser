import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wing_browser/feature/webview/web_view_model.dart';

class UrlFieldModel {
  static Future<void> onSubmitted(
      String string, InAppWebViewController? webViewController, WidgetRef ref, BuildContext context) async {
    try {
      final uri = Uri.parse(string);

      final correctedUri = uri.scheme.isEmpty
          ? WebUri("http://$string") // HTTP をデフォルトとする
          : WebUri(string);

      await webViewController?.loadUrl(
        urlRequest: URLRequest(url: correctedUri),
      );
      // 状態を更新
      ref.read(webViewProvider.notifier).setUrl(correctedUri);
    } catch (e) {
      // 無効なURLの場合のエラーハンドリング
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invalid URL")),
        );
      }
    }
  }
}
