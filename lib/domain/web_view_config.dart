// domain/web_view_config.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'web_view_config.freezed.dart';

@freezed
abstract class WebViewConfig with _$WebViewConfig {
  const factory WebViewConfig({
    required InAppWebViewSettings settings,
    required PullToRefreshSettings pullToRefreshSettings,
    required WebUri initialUrl,
  }) = _WebViewConfig;
}

final defaultWebViewConfig = WebViewConfig(
  settings: InAppWebViewSettings(isInspectable: kDebugMode),
  pullToRefreshSettings: PullToRefreshSettings(color: Colors.blue),
  initialUrl: WebUri("https://www.google.co.jp"),
);

class WebViewConfigNotifier extends Notifier<WebViewConfig> {
  void updateSettings(InAppWebViewSettings newSettings) {
    state = state.copyWith(settings: newSettings);
  }

  void updatePullToRefreshSettings(PullToRefreshSettings newPullToRefreshSettings) {
    state = state.copyWith(pullToRefreshSettings: newPullToRefreshSettings);
  }

  void updateInitialUrl(String newInitialUrl) {
    state = state.copyWith(initialUrl: WebUri(newInitialUrl));
  }

  @override
  WebViewConfig build() {
    return defaultWebViewConfig;
  }
}

final webViewConfigProvider = NotifierProvider<WebViewConfigNotifier, WebViewConfig>(() {
  return WebViewConfigNotifier();
});
