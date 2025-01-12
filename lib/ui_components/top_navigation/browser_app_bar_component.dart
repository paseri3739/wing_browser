import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BrowserAppBarComponent extends ConsumerWidget implements PreferredSizeWidget {
  const BrowserAppBarComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backgroundColor = Theme.of(context).appBarTheme.backgroundColor;
    return AppBar(title: const Text("Tab Bar"), backgroundColor: backgroundColor);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
