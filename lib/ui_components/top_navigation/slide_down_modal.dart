import 'package:flutter/material.dart';

class SlideDownModal {
  static void show(BuildContext context) {
    final overlay = Overlay.of(context);
    late final OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => _SlideDownContent(
        onClose: () => overlayEntry.remove(),
      ),
    );

    overlay.insert(overlayEntry);
  }
}

class _SlideDownContent extends StatefulWidget {
  final VoidCallback onClose;

  const _SlideDownContent({required this.onClose});

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
                          child: Text('上から出てくるモーダル'),
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
