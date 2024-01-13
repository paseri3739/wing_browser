import 'package:flutter/material.dart';

class BrowserAppBarComponent extends StatelessWidget
    implements PreferredSizeWidget {
  const BrowserAppBarComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(title: const Text("Tab Bar"), backgroundColor: Colors.blue);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
