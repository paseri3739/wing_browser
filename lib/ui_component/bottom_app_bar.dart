import 'package:flutter/material.dart';
import 'package:wing_browser/ui_component/browser_popup_menu.dart';

/// BottomAppBar for Browsing Page
class BrowserBottomAppBar extends StatelessWidget {
  final double height;
  const BrowserBottomAppBar({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 5.0,
        color: Colors.blueGrey,
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
            const Spacer(),
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
