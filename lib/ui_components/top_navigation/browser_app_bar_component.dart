import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wing_browser/domain/web_view_model.dart';

class BrowserAppBarComponent extends ConsumerWidget implements PreferredSizeWidget {
  final double height;

  const BrowserAppBarComponent({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backgroundColor = Theme.of(context).appBarTheme.backgroundColor;
    final controller = ref.watch(webViewStateProvider).webViewController;

    return AppBar(
      backgroundColor: backgroundColor,
      toolbarHeight: height,
      centerTitle: true,
      title: FutureBuilder(
        future: Future.wait([
          controller.getTitle(),
          controller.getFavicons(),
        ]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          final title = switch (snapshot.connectionState) {
            ConnectionState.waiting => 'Loading...',
            ConnectionState.done when snapshot.hasError => 'Error',
            ConnectionState.done when snapshot.hasData => snapshot.data![0] ?? 'No Title',
            _ => 'No Title',
          };

          final List<Favicon> favicons =
              snapshot.hasData && snapshot.data![1] is List<Favicon> ? List<Favicon>.from(snapshot.data![1]) : [];

          final faviconUrl = favicons.isNotEmpty ? favicons.first.url.toString() : null;

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            constraints: const BoxConstraints(maxWidth: 300),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (faviconUrl != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Image.network(
                      faviconUrl,
                      width: 20,
                      height: 20,
                      errorBuilder: (_, __, ___) => const SizedBox(width: 20, height: 20),
                    ),
                  ),
                Flexible(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
