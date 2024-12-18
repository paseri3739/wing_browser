import 'package:flutter/material.dart';

class SquareIconButton extends StatelessWidget {
  const SquareIconButton({
    super.key,
    required this.height,
    required this.icon,
    required this.color,
  });

  final double height;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: height, // IconButtonが正方形になるように幅も高さに合わせる
      child: IconButton(
        icon: Icon(icon, color: color),
        onPressed: () {},
        padding: EdgeInsets.zero, // パディングを0に設定する
        constraints: const BoxConstraints(), // ボタンの制約を追加してサイズを調整する
      ),
    );
  }
}
