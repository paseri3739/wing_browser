import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main(List<String> args) {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      top: true,
      bottom: false,
      child: Scaffold(
        // Hide Floating button when keyboard appeared
        resizeToAvoidBottomInset: false,
        appBar: AppBarComponent(),
        body: Column(children: [UrlField(), Expanded(child: HomePage())]),
        bottomNavigationBar: Bottoms(),
        floatingActionButton: SearchButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  const AppBarComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(title: const Text("Tab Bar"), backgroundColor: Colors.blue);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class UrlField extends StatelessWidget {
  const UrlField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 40.0,
        width: 400,
        child: TextField(
          onSubmitted: (string) {},
          textInputAction: TextInputAction.go,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(10.0),
            filled: true,
            fillColor: Colors.white,
            hintText: "Search For ...",
            hintStyle: TextStyle(color: Colors.black54, fontSize: 16.0),
          ),
          style: const TextStyle(color: Colors.black, fontSize: 16.0),
        ));
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

class Bottoms extends StatelessWidget {
  const Bottoms({super.key});

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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late InAppWebViewController _webViewController;
  final initUrl = WebUri("https://www.google.com");
  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: URLRequest(url: initUrl),
      onWebViewCreated: (InAppWebViewController controller) {
        _webViewController = controller;
      },
    );
  }
}
