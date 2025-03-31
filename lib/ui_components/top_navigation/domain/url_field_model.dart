import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/web_view_model.dart';

// URLバーのドメインモデル。これをriverpod経由で公開しDIする。
class UrlFieldModel {
  final bool isLoading;

  UrlFieldModel({
    this.isLoading = false,
  });

  // null許容しない
  static Future<void> onSubmitted(
      String string, InAppWebViewController webViewController, WidgetRef ref, BuildContext context) async {
    try {
      final uri = Uri.parse(string);

      final correctedUri = uri.scheme.isEmpty
          ? WebUri("http://$string") // HTTP をデフォルトとする
          : WebUri(string);

      await webViewController.loadUrl(
        urlRequest: URLRequest(url: correctedUri),
      );
      // 状態を更新
      ref.read(webViewProvider.notifier).update(url: correctedUri);
    } catch (e) {
      // 無効なURLの場合のエラーハンドリング
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invalid URL")),
        );
      }
    }
  }

  UrlFieldModel onLockButtonPressed() {
    return this;
  }

  UrlFieldModel copyWith({
    bool? isLoading,
  }) {
    return UrlFieldModel(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
