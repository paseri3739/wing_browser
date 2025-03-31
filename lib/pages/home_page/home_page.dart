import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wing_browser/domain/web_view_model.dart';
import 'package:wing_browser/feature/webview/web_view_home_page.dart';
import 'package:wing_browser/pages/home_page/style/screen_metrics.dart';
import 'package:wing_browser/ui_components/bottom_navigation/bottom_app_bar.dart';
import 'package:wing_browser/ui_components/bottom_navigation/search_button.dart';
import 'package:wing_browser/ui_components/top_navigation/browser_app_bar_component.dart';
import 'package:wing_browser/ui_components/top_navigation/url_field.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final webViewAsyncValue = ref.watch(webViewProvider);

    // レイアウト用のパラメータ
    final screenHeight = MediaQuery.of(context).size.height;
    // TODO: Riverpod管理下にする
    final screenMetrics = ScreenMetrics(screenHeight: screenHeight);

    // WebView は常にビルドし、onWebViewCreated などを走らせる
    // -> コントローラが取得できたら provider 側が `AsyncData` に遷移する
    final webViewWidget = const Expanded(child: WebViewHomePage());

    // 非 nullable なコントローラを必要とするウィジェットは、
    // WebViewAsyncValue の状態に応じて切り替える
    // (まだコントローラがない = loading/error のときは別表示)
    final appBarWidget = webViewAsyncValue.when(
      data: (webViewState) {
        // ここは非 nullable な webViewController が取れる
        return BrowserAppBarComponent(
          // TODO: プロパティとしてバケツリレーせず、single source of truth を守る
          webViewController: webViewState.webViewController,
          height: screenMetrics.appBarPixel,
        );
      },
      loading: () => const SizedBox.shrink(), // ローディング中は空やプレースホルダーなど
      error: (error, stack) => Center(child: Text('Error: $error')),
    );

    final urlFieldWidget = webViewAsyncValue.when(
      data: (webViewState) {
        return UrlField(
          height: screenMetrics.urlFieldPixel,
          webViewController: webViewState.webViewController,
        );
      },
      loading: () => SizedBox(height: screenMetrics.urlFieldPixel),
      error: (error, stack) => SizedBox(height: screenMetrics.urlFieldPixel),
    );

    // ローディング・エラー時に重ねて表示するレイヤー
    final overlayWidget = webViewAsyncValue.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
      data: (_) => const SizedBox.shrink(),
    );

    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Column(
              children: [
                // コントローラがまだなくても、とりあえずビルドはする
                // コントローラが取れるようになったら自動的に上書きして再描画
                appBarWidget,
                urlFieldWidget,
                webViewWidget,
              ],
            ),
            overlayWidget,
          ],
        ),
        bottomNavigationBar: BrowserBottomAppBar(height: screenMetrics.bottomAppBarPixel),
        floatingActionButton: const SearchButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
