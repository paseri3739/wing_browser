// domain/web_view_config.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WebViewConfig {
  final InAppWebViewSettings settings;
  final PullToRefreshSettings pullToRefreshSettings;
  final String initialUrl;

  const WebViewConfig({
    required this.settings,
    required this.pullToRefreshSettings,
    required this.initialUrl,
  });

  WebViewConfig copyWith({
    InAppWebViewSettings? settings,
    PullToRefreshSettings? pullToRefreshSettings,
    String? initialUrl,
  }) {
    return WebViewConfig(
      settings: settings ?? this.settings,
      pullToRefreshSettings: pullToRefreshSettings ?? this.pullToRefreshSettings,
      initialUrl: initialUrl ?? this.initialUrl,
    );
  }
}

final defaultWebViewConfig = WebViewConfig(
  settings: InAppWebViewSettings(isInspectable: kDebugMode),
  pullToRefreshSettings: PullToRefreshSettings(color: Colors.blue),
  initialUrl: "https://www.google.com",
);

class WebViewConfigNotifier extends Notifier<WebViewConfig> {
  void updateSettings(InAppWebViewSettings newSettings) {
    state = state.copyWith(settings: newSettings);
  }

  void updatePullToRefreshSettings(PullToRefreshSettings newPullToRefreshSettings) {
    state = state.copyWith(pullToRefreshSettings: newPullToRefreshSettings);
  }

  void updateInitialUrl(String newInitialUrl) {
    state = state.copyWith(initialUrl: newInitialUrl);
  }

  @override
  WebViewConfig build() {
    return defaultWebViewConfig;
  }
}

final webViewConfigProvider = NotifierProvider<WebViewConfigNotifier, WebViewConfig>(() {
  return WebViewConfigNotifier();
});
