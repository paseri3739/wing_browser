import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wing_browser/webview/web_view_home_page.dart';

class BrowserAppBarComponent extends ConsumerWidget implements PreferredSizeWidget {
  const BrowserAppBarComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(webViewProvider).progress;

    return Stack(
      children: [
        AppBar(title: const Text("Tab Bar"), backgroundColor: Colors.white),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: LinearProgressIndicator(
              backgroundColor: Colors.white,
              value: progress,
            ))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
