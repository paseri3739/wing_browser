import 'package:flutter/material.dart';
import 'package:wing_browser/feature/webview/web_view_home_page.dart';
import 'package:wing_browser/ui_components/bottom_navigation/bottom_app_bar.dart';
import 'package:wing_browser/ui_components/bottom_navigation/search_button.dart';
import 'package:wing_browser/ui_components/top_navigation/browser_app_bar_component.dart';
import 'package:wing_browser/ui_components/top_navigation/url_field.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // SafeArea: avoid being hidden by the system ui
    // 画面の高さ（論理ピクセル）を取得する
    final screenHeight = MediaQuery.of(context).size.height;
    final double urlFieldRatio = 0.03;
    final double urlFieldPixel = screenHeight * urlFieldRatio;
    final double bottonAppBarRatio = 0.075;
    final double bottomAppBarPixel = screenHeight * bottonAppBarRatio;

    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        // true: extend body to bottom of the screen. avoid blank notched area
        extendBody: true,
        // Hide Floating button when keyboard appeared
        resizeToAvoidBottomInset: false,
        appBar: BrowserAppBarComponent(),
        body: Column(children: [
          UrlField(
            height: urlFieldPixel, // 3% of screen height
          ),
          Expanded(child: WebViewHomePage())
        ]),
        // TODO: remove shade when dark mode
        bottomNavigationBar: BrowserBottomAppBar(height: bottomAppBarPixel),
        floatingActionButton: SearchButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
