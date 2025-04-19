import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wing_browser/ui_components/common/square_icon_button.dart';
import 'package:wing_browser/ui_components/top_navigation/slide_down_modal.dart';

class LockButton extends ConsumerStatefulWidget {
  final double height;
  final IconData icon;
  final Color color;

  const LockButton({
    super.key,
    required this.height,
    required this.icon,
    required this.color,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return LockButtonState();
  }
}

class LockButtonState extends ConsumerState<LockButton> {
  @override
  Widget build(BuildContext context) {
    return SquareIconButton(
      height: widget.height,
      icon: widget.icon,
      color: widget.color,
      onPressed: () {
        SlideDownModal.show(context);
      },
    );
  }
}
