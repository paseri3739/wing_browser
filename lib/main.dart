import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wing_browser/ui_components/bottomNavigation/search_button.dart';

import 'ui_components/bottomNavigation/bottom_app_bar.dart';
import 'ui_components/topNavigation/browser_app_bar_component.dart';
import 'ui_components/topNavigation/url_field.dart';
import 'webview/web_view_home_page.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await InAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

  runApp(ProviderScope(
    child: MaterialApp(
      home: MyApp(),
      theme: ThemeData.light(), // ライトテーマ
      darkTheme: ThemeData.dark(), // ダークテーマ
      themeMode: ThemeMode.system, // システムのテーマに従う
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // SafeArea: avoid being hidden by the system ui
    return const SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        // Hide Floating button when keyboard appeared
        resizeToAvoidBottomInset: false,
        appBar: BrowserAppBarComponent(),
        body: Column(children: [
          UrlField(
            height: 30, //マジックナンバー
          ),
          Expanded(child: WebViewHomePage())
        ]),
        // TODO: Responsive height
        bottomNavigationBar: BrowserBottomAppBar(height: 70),
        floatingActionButton: SearchButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
