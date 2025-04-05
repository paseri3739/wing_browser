import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wing_browser/domain/web_view_model.dart';
import 'package:wing_browser/ui_components/top_navigation/lock_button.dart';
import 'package:wing_browser/ui_components/top_navigation/reload_button.dart';
import 'package:wing_browser/ui_components/top_navigation/url_text_field.dart';

class UrlField extends ConsumerWidget {
  final double height; // 高さを指定するプロパティ

  const UrlField({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController controller = TextEditingController();
    final webViewState = ref.watch(webViewStateProvider);
    final url = webViewState.currentUrl;
    final theme = Theme.of(context);
    final reloadButtonColor = theme.brightness == Brightness.dark ? Colors.white : Colors.black;

    // URLを反映
    if (controller.text != url.toString()) {
      controller.text = url.toString();
    }

    // アイコンを動的に設定
    IconData lockIcon = (url.scheme == 'https') ? Icons.lock : Icons.lock_open;
    Color iconColor = (url.scheme == 'https') ? Colors.green : Colors.red;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // 上下に8.0のパディングを適用 FIXME: マジックナンバー
      child: Column(
        children: [
          Row(
            children: <Widget>[
              LockButton(
                height: height,
                icon: lockIcon,
                color: iconColor,
              ),
              UrlTextField(controller: controller, height: height),
              ReloadButton(
                height: height,
                reloadButtonColor: reloadButtonColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// リロードボタンをタップした際、ロード完了までアイコンがXに変わるように実装したConsumerStatefulWidget
