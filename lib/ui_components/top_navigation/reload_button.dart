import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wing_browser/feature/webview/domain/web_view_model.dart';
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
  _ReloadButtonState createState() => _ReloadButtonState();
}

class _ReloadButtonState extends ConsumerState<ReloadButton> {
  bool _isLoading = false;

  Future<void> _onPressed() async {
    setState(() {
      _isLoading = true;
    });
    // リロード実行
    final webViewState = ref.read(webViewStateProvider);
    await webViewState.webViewController.reload(); // プログレスをプログレスバーのウィジェットが監視することでUIが変更される。
  }

  @override
  Widget build(BuildContext context) {
    final stateData = ref.watch(webViewStateProvider);
    final progress = stateData.loadingProgress.progress;

    // 進捗が完了している場合は、ローディング状態を解除
    if (progress >= 1.0 && _isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }

    return SquareIconButton(
      height: widget.height,
      // ローディング中はXアイコン、通常はリフレッシュアイコンを表示
      icon: _isLoading ? Icons.close : Icons.refresh,
      color: widget.reloadButtonColor,
      onPressed: _onPressed,
    );
  }
}
