import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wing_browser/feature/theme/application_theme.dart';
import 'package:wing_browser/pages/home_page/home_page.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await InAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);
    // final theme = ref.watch(themeProvider);
    return MaterialApp(
      home: HomePage(),
      theme: lightTheme, // ライトテーマ
      darkTheme: darkTheme, // ダークテーマ
      themeMode: themeMode, // システムのテーマに従う TODO: ユーザー設定の反映
    );
  }
}
