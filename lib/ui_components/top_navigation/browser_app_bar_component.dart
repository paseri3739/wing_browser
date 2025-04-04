import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BrowserAppBarComponent extends ConsumerWidget implements PreferredSizeWidget {
  final double height;

  const BrowserAppBarComponent({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backgroundColor = Theme.of(context).appBarTheme.backgroundColor;
    return AppBar(
      title: const Text("Tab Bar"),
      backgroundColor: backgroundColor,
      toolbarHeight: height,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
