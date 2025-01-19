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
    return const SafeArea(
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
            height: 30, // FIXME: マジックナンバー
          ),
          Expanded(child: WebViewHomePage())
        ]),
        // TODO: Responsive height
        // TODO: remove shade when dark mode
        bottomNavigationBar: BrowserBottomAppBar(height: 70),
        floatingActionButton: SearchButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
