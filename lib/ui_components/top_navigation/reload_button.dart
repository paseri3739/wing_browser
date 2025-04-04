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
    await webViewState.webViewController.reload(); // プログレスをプログレスバーのウィジェットが監視することでUIが変更される。
  }

  @override
  Widget build(BuildContext context) {
    final webViewState = ref.watch(webViewStateProvider);
    final progress = webViewState.loadingProgress.progress;

    return SquareIconButton(
      height: widget.height,
      // ローディング中はXアイコン、通常はリフレッシュアイコンを表示
      icon: progress != 0.0 ? Icons.close : Icons.refresh,
      color: widget.reloadButtonColor,
      onPressed: _onPressed,
    );
  }
}
