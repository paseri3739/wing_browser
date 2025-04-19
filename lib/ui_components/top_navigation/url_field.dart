import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wing_browser/domain/web_view_model.dart';
import 'package:wing_browser/ui_components/top_navigation/lock_button.dart';
import 'package:wing_browser/ui_components/top_navigation/reload_button.dart';
import 'package:wing_browser/ui_components/top_navigation/url_text_field.dart';

class UrlField extends ConsumerWidget {
  final double height;

  const UrlField({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final webViewController = ref.watch(webViewStateProvider).webViewController;
    final theme = Theme.of(context);
    final reloadButtonColor = theme.brightness == Brightness.dark ? Colors.white : Colors.black;
    final controller = TextEditingController();

    return FutureBuilder<WebUri?>(
      future: webViewController.getUrl(),
      builder: (context, snapshot) {
        final url = snapshot.data;
        final scheme = url?.scheme ?? '';

        // 入力欄にURLを反映（WebViewのURLと異なるときのみ）
        if (url != null && controller.text != url.toString()) {
          controller.text = url.toString();
        }

        final IconData lockIcon = scheme == 'https' ? Icons.lock : Icons.lock_open;
        final Color iconColor = scheme == 'https' ? Colors.green : Colors.red;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0), // FIXME: マジックナンバー
          child: Row(
            children: <Widget>[
              LockButton(
                height: height,
                icon: lockIcon,
                color: iconColor,
              ),
              UrlTextField(
                controller: controller,
                height: height,
              ),
              ReloadButton(
                height: height,
                reloadButtonColor: reloadButtonColor,
              ),
            ],
          ),
        );
      },
    );
  }
}
