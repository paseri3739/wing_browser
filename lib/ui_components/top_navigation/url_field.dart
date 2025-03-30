import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wing_browser/feature/webview/web_view_model.dart';
import 'package:wing_browser/ui_components/common/square_icon_button.dart';
import 'package:wing_browser/ui_components/top_navigation/domain/url_field_model.dart';

class UrlField extends ConsumerWidget {
  final double height; // 高さを指定するプロパティ

  const UrlField({
    super.key,
    this.height = 40.0, // デフォルトの高さ
  });

  // UrlFieldの各要素は更新のタイミングと範囲が同一のためクラスにせず、関数で定義した
  SquareIconButton _buildLockButton(IconData icon, Color color, double height) {
    return SquareIconButton(
      height: height,
      icon: icon,
      color: color,
      // TODO: ロックアイコンの処理を追加
      onPressed: () {},
    );
  }

  Expanded _buildUrlTextField(TextEditingController controller, InAppWebViewController? webViewController,
      WidgetRef ref, BuildContext context, double height) {
    return Expanded(
      child: SizedBox(
        height: height,
        child: TextField(
          controller: controller,
          textAlign: TextAlign.center,
          onSubmitted: (string) async {
            await UrlFieldModel.onSubmitted(string, webViewController, ref, context);
          },
          textInputAction: TextInputAction.go,
          decoration: InputDecoration(
            isDense: false,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 16.0,
            ),
            filled: true,
            fillColor: Colors.grey[300],
            hintText: "Search For ...",
            hintStyle: const TextStyle(color: Colors.black54, fontSize: 16.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3.0),
              borderSide: BorderSide.none,
            ),
          ),
          style: const TextStyle(color: Colors.black, fontSize: 16.0),
        ),
      ),
    );
  }

  SquareIconButton _buildReloadButton(
      Color reloadButtonColor, InAppWebViewController? webViewController, double height) {
    return SquareIconButton(
      height: height,
      icon: Icons.refresh,
      color: reloadButtonColor,
      onPressed: () async {
        await webViewController?.reload();
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController controller = TextEditingController();
    final WebUri? url = ref.watch(webViewProvider).url;
    final progress = ref.watch(webViewProvider).progress;
    final InAppWebViewController? webViewController = ref.watch(webViewProvider).webViewController;
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
              _buildLockButton(lockIcon, iconColor, height),
              _buildUrlTextField(controller, webViewController, ref, context, height),
              _buildReloadButton(reloadButtonColor, webViewController, height),
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
