import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wing_browser/domain/web_view_model.dart';

class BrowserAppBarComponent extends ConsumerWidget implements PreferredSizeWidget {
  const BrowserAppBarComponent({super.key, required this.height});
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(webViewStateProvider); // 例外発生＝未初期化
    final bg = Theme.of(context).appBarTheme.backgroundColor;

    return AppBar(
      backgroundColor: bg,
      toolbarHeight: height,
      centerTitle: true,
      title: _TitleBox(
        title: model.currentTabTitle.title.isEmpty ? 'Loading...' : model.currentTabTitle.title,
        faviconUrl: model.faviconUrl,
      ),
      bottom: model.isLoading
          ? const PreferredSize(
              preferredSize: Size.fromHeight(2),
              child: LinearProgressIndicator(minHeight: 2),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

// Row の部品はそのまま流用
class _TitleBox extends StatelessWidget {
  const _TitleBox({required this.title, this.faviconUrl});
  final String title;
  final String? faviconUrl;

  @override
  Widget build(BuildContext context) {
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
                faviconUrl!,
                width: 20,
                height: 20,
                errorBuilder: (_, __, ___) => const SizedBox(width: 20, height: 20),
              ),
            ),
          Flexible(
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, color: Colors.black),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
