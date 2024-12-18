import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wing_browser/ui_component/search_button.dart';

import 'ui_component/bottom_app_bar.dart';
import 'ui_component/browser_app_bar_component.dart';
import 'ui_component/url_field.dart';
import 'webview_tab/web_view_home_page.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(
    child: MaterialApp(
      home: MyApp(),
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
      bottom: false,
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
