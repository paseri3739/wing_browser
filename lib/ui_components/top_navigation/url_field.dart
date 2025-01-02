import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wing_browser/ui_components/common/square_icon_button.dart';
import 'package:wing_browser/webview/state/web_view_model.dart';

class UrlField extends ConsumerWidget {
  final double height; // 高さを指定するプロパティ

  const UrlField({
    super.key,
    this.height = 40.0, // デフォルトの高さ
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController controller = TextEditingController();
    final WebUri? url = ref.watch(webViewProvider).url;
    final progress = ref.watch(webViewProvider).progress;
    final InAppWebViewController? webViewController = ref.watch(webViewProvider).webViewController;

    // URLを反映
    if (url != null && controller.text != url.toString()) {
      controller.text = url.toString();
    }

    // アイコンを動的に設定
    IconData lockIcon = (url?.scheme == 'https') ? Icons.lock : Icons.lock_open;
    Color iconColor = (url?.scheme == 'https') ? Colors.green : Colors.red;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // 上下に8.0のパディングを適用
      child: Column(
        children: [
          Stack(
            children: [
              Row(
                children: <Widget>[
                  SquareIconButton(
                    height: height,
                    icon: lockIcon,
                    color: iconColor,
                    onPressed: () {},
                  ),
                  Expanded(
                    child: SizedBox(
                      height: height,
                      child: TextField(
                        controller: controller,
                        textAlign: TextAlign.center,
                        onSubmitted: (string) async {
                          if (webViewController != null) {
                            try {
                              // 入力された文字列が有効なURLかチェック
                              final uri = Uri.parse(string);

                              // スキームが空の場合は http:// を補完
                              final correctedUri = uri.scheme.isEmpty
                                  ? WebUri("http://$string") // HTTP をデフォルトとする
                                  : WebUri(string);

                              // URLをロード
                              await webViewController.loadUrl(
                                urlRequest: URLRequest(url: correctedUri),
                              );

                              // 状態を更新
                              ref.read(webViewProvider.notifier).setUrl(correctedUri);
                            } catch (e) {
                              // 無効なURLの場合のエラーハンドリング
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Invalid URL")),
                              );
                            }
                          }
                        },
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                          isDense: false,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 16.0,
                          ),
                          filled: true,
                          fillColor: Colors.grey[300],
                          hintText: "Search For ...",
                          hintStyle: const TextStyle(color: Colors.black54, fontSize: 16.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                    ),
                  ),
                  SquareIconButton(
                    height: height,
                    icon: Icons.refresh,
                    color: Colors.black,
                    onPressed: () async {
                      await webViewController?.reload();
                    },
                  ),
                ],
              ),
              // FIXME: プログレスバーの表示位置を調整
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Visibility(
                  visible: progress > 0,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.white,
                    value: progress,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
