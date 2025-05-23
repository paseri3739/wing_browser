import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wing_browser/domain/web_view_model.dart';
import 'package:wing_browser/ui_components/common/square_icon_button.dart';

class ReloadButton extends ConsumerStatefulWidget {
  final double height;
  final Color reloadButtonColor;

  const ReloadButton({
    super.key,
    required this.height,
    required this.reloadButtonColor,
  });

  @override
  ReloadButtonState createState() => ReloadButtonState();
}

class ReloadButtonState extends ConsumerState<ReloadButton> {
  Future<void> _onPressed() async {
    // リロード実行
    final webViewState = ref.read(webViewStateProvider);
    final webViewNotifier = ref.read(webViewProvider.notifier);
    if (webViewState.isLoading) {
      // ローディング中はリロードをキャンセル
      webViewState.webViewController.stopLoading();
      webViewNotifier.update(loadingProgress: LoadingProgress(0.0));
      return;
    }
    await webViewState.webViewController.reload(); // プログレスをプログレスバーのウィジェットが監視することでUIが変更される。
  }

  @override
  Widget build(BuildContext context) {
    final webViewState = ref.watch(webViewStateProvider);

    return SquareIconButton(
      height: widget.height,
      // ローディング中はXアイコン、通常はリフレッシュアイコンを表示
      icon: webViewState.isLoading ? Icons.close : Icons.refresh,
      color: widget.reloadButtonColor,
      onPressed: _onPressed,
    );
  }
}
