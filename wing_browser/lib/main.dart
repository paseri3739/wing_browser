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
    return SafeArea(
      top: true,
      bottom: false,
      child: Scaffold(
        appBar:
            AppBar(title: const Text("Hello"), backgroundColor: Colors.blue),
        body: const HomePage(),
        bottomNavigationBar: const Bottoms(),
        floatingActionButton: const SearchButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
          children: <Widget>[
            IconButton(
              tooltip: 'Open navigation menu',
              icon: const Icon(Icons.menu),
              onPressed: () {},
            ),
            IconButton(
              tooltip: 'Search',
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              tooltip: 'Favorite',
              icon: const Icon(Icons.favorite),
              onPressed: () {},
            ),
          ],
        ),
      ),
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
