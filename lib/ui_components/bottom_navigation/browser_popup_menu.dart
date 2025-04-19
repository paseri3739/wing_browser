import 'package:flutter/material.dart';

// FIXME: PopupMenuItemがクリックされると全然関係ないテキストボックスにフォーカスが当たる。
// 内部的に新しいフォーカスノードを作成している?
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
