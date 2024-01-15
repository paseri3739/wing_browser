import 'package:flutter/material.dart';

import 'bottom_app_bar.dart';
import 'browser_app_bar_component.dart';
import 'url_field.dart';
import 'web_view_home_page.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      top: true,
      bottom: false,
      child: Scaffold(
        // Hide Floating button when keyboard appeared
        resizeToAvoidBottomInset: false,
        appBar: BrowserAppBarComponent(),
        body:
            Column(children: [UrlField(), Expanded(child: WebViewHomePage())]),
        bottomNavigationBar: BrowserBottomAppBar(),
        floatingActionButton: SearchButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
