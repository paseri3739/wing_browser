import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wing_browser/feature/webview/domain/web_view_model.dart';
import 'package:wing_browser/ui_components/bottom_navigation/browser_popup_menu.dart';

/// BottomAppBar for Browsing Page
class BrowserBottomAppBar extends ConsumerWidget {
  final double height;
  const BrowserBottomAppBar({super.key, required this.height});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(webViewProvider);
    final webViewController = asyncState.maybeWhen(
      data: (data) => data.webViewController,
      orElse: () => null,
    );

    return SizedBox(
      height: height,
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 5.0,
        color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // 子要素を左右に分散させる
          children: <Widget>[
            IconButton(
              tooltip: 'Back',
              icon: const Icon(Icons.arrow_back),
              onPressed: () async {
                if (await webViewController!.canGoBack()) {
                  webViewController.goBack();
                }
              },
            ),
            IconButton(
              tooltip: 'Forward',
              icon: const Icon(Icons.arrow_forward),
              onPressed: () async {
                if (await webViewController!.canGoForward()) {
                  webViewController.goForward();
                }
              },
            ),
            const Spacer(),
            IconButton(
              tooltip: 'Favorite',
              icon: const Icon(Icons.star),
              onPressed: () {},
            ),
            const BrowserPopupMenu(),
          ],
        ),
      ),
    );
  }
}
