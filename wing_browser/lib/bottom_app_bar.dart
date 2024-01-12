import 'package:flutter/material.dart';

class BrowserBottomAppBar extends StatelessWidget {
  const BrowserBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.white70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // 子要素を左右に分散させる
          children: <Widget>[
            IconButton(
              tooltip: 'Back',
              icon: const Icon(Icons.arrow_back),
              onPressed: () {},
            ),
            IconButton(
              tooltip: 'Forward',
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {},
            ),
            IconButton(
              tooltip: 'Favorite',
              icon: const Icon(Icons.star),
              onPressed: () {},
            ),
            const BrowserPopupMenu(),
          ],
        ),
      ),
    );
  }
}

class SearchButton extends StatelessWidget {
  const SearchButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        onPressed: () => {},
        child: const Icon(Icons.search));
  }
}

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
