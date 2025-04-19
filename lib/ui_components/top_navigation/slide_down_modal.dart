import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wing_browser/domain/web_view_model.dart';

class SlideDownModal {
  static void show(BuildContext context, WidgetRef ref) {
    final overlay = Overlay.of(context);
    late final OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => _SlideDownContent(
        onClose: () => overlayEntry.remove(),
        ref: ref,
      ),
    );

    overlay.insert(overlayEntry);
  }
}

class _SlideDownContent extends StatefulWidget {
  final VoidCallback onClose;
  final WidgetRef ref;

  const _SlideDownContent({required this.onClose, required this.ref});

  @override
  State<_SlideDownContent> createState() => _SlideDownContentState();
}

class _SlideDownContentState extends State<_SlideDownContent> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = Tween<Offset>(
      begin: Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _close() async {
    await _controller.reverse();
    widget.onClose();
  }

  TextSpan _colorizeUrl(String url) {
    final match = RegExp(r'^(https?)').firstMatch(url);

    if (match != null) {
      final scheme = match.group(0)!;
      final rest = url.substring(scheme.length);

      return TextSpan(
        children: [
          TextSpan(
            text: scheme,
            style: TextStyle(
              color: scheme == 'https' ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: rest,
            style: TextStyle(color: Colors.black),
          ),
        ],
      );
    }

    // マッチしなかった場合はそのまま黒文字で表示
    return TextSpan(text: url, style: TextStyle(color: Colors.black));
  }

  Widget _buildSecurityLabel(String url) {
    final isSecure = url.startsWith('https');

    return Text(
      isSecure ? '接続は保護されています' : '接続は保護されていません',
      style: TextStyle(
        color: isSecure ? Colors.green : Colors.red,
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black54, // 背景の暗い半透明
      child: GestureDetector(
        onTap: _close, // 背景タップで閉じる
        child: Stack(
          children: [
            SlideTransition(
              position: _animation,
              child: Align(
                alignment: Alignment.topCenter,
                child: SafeArea(
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // URL表示（カラー付き）
                              SizedBox(
                                width: double.infinity,
                                child: Text.rich(
                                  _colorizeUrl(widget.ref.read(webViewStateProvider).currentUrl.toString()),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: false,
                                ),
                              ),

                              const SizedBox(height: 8),

                              // 接続の安全性表示
                              _buildSecurityLabel(widget.ref.read(webViewStateProvider).currentUrl.toString()),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _close,
                          child: Text("閉じる"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
