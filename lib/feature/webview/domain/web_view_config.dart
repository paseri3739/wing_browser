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
}

var defaultWebViewConfig = WebViewConfig(
  settings: InAppWebViewSettings(isInspectable: kDebugMode),
  pullToRefreshSettings: PullToRefreshSettings(color: Colors.blue),
  initialUrl: "https://www.google.com",
);

final webViewConfigProvider = Provider<WebViewConfig>((ref) {
  return defaultWebViewConfig;
});
