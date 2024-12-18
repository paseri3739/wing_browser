import 'package:flutter/material.dart';

class BrowserPopupMenu extends StatelessWidget {
  const BrowserPopupMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      // Callback that sets the selected popup menu item.
      onSelected: (item) {},
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem(
          child: Text('Item 1'),
        ),
        const PopupMenuItem(child: Text("Item 2"))
      ],
    );
  }
}
