import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wing_browser/domain/web_view_model.dart';

class BrowserAppBarComponent extends ConsumerWidget implements PreferredSizeWidget {
  final double height;

  const BrowserAppBarComponent({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backgroundColor = Theme.of(context).appBarTheme.backgroundColor;
    final controller = ref.watch(webViewStateProvider).webViewController;
    return AppBar(
      title: FutureBuilder<String?>(
        future: controller.getTitle(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          } else if (snapshot.hasError) {
            return const Text('Error');
          } else {
            return Text(snapshot.data ?? 'No Title');
          }
        },
      ),
      backgroundColor: backgroundColor,
      toolbarHeight: height,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
