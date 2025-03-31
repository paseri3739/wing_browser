import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wing_browser/feature/webview/domain/web_view_model.dart';
import 'package:wing_browser/ui_components/common/square_icon_button.dart';
import 'package:wing_browser/ui_components/top_navigation/reload_button.dart';
import 'package:wing_browser/ui_components/top_navigation/url_text_field.dart';

class UrlField extends ConsumerWidget {
  final double height; // 高さを指定するプロパティ
  final InAppWebViewController webViewController;

  const UrlField({
    super.key,
    required this.height,
    required this.webViewController,
  });

  // UrlFieldの各要素は更新のタイミングと範囲が同一のためクラスにせず、関数で定義した
  SquareIconButton _buildLockButton(IconData icon, Color color, double height, WidgetRef ref) {
    return SquareIconButton(
      height: height,
      icon: icon,
      color: color,
      // TODO: ロックアイコンの処理を追加
      onPressed: () {},
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController controller = TextEditingController();
    final asyncState = ref.watch(webViewProvider);
    final url = asyncState.maybeWhen(
      data: (data) => data.currentUrl,
      orElse: () => null,
    );
    final progress = asyncState.maybeWhen(
      data: (data) => data.loadingProgress.progress,
      orElse: () => 0.0,
    );
    final theme = Theme.of(context);
    final reloadButtonColor = theme.brightness == Brightness.dark ? Colors.white : Colors.black;

    // URLを反映
    if (url != null && controller.text != url.toString()) {
      controller.text = url.toString();
    }

    // アイコンを動的に設定
    IconData lockIcon = (url?.scheme == 'https') ? Icons.lock : Icons.lock_open;
    Color iconColor = (url?.scheme == 'https') ? Colors.green : Colors.red;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // 上下に8.0のパディングを適用
      child: Column(
        children: [
          Row(
            children: <Widget>[
              _buildLockButton(lockIcon, iconColor, height, ref),
              UrlTextField(controller: controller, height: height),
              ReloadButton(
                height: height,
                reloadButtonColor: reloadButtonColor,
              ),
            ],
          ),
          // FIXME: プログレスバーの表示位置を調整
          Visibility(
            visible: progress > 0,
            child: LinearProgressIndicator(
              backgroundColor: Colors.white,
              value: progress,
            ),
          )
        ],
      ),
    );
  }
}

// リロードボタンをタップした際、ロード完了までアイコンがXに変わるように実装したConsumerStatefulWidget
