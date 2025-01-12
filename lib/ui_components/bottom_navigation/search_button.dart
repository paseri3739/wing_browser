import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).floatingActionButtonTheme.backgroundColor;
    return FloatingActionButton(
        backgroundColor: backgroundColor ?? Colors.blue,
        shape: const CircleBorder(),
        onPressed: () => {},
        child: const Icon(Icons.search));
  }
}
