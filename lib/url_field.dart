import 'package:flutter/material.dart';

class UrlField extends StatelessWidget {
  final double height; // 高さを指定するプロパティ

  const UrlField({
    super.key,
    this.height = 40.0, // デフォルトの高さ
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height, // ここでウィジェットの高さを設定してすべてに適用する
      child: Row(
        children: <Widget>[
          SquareIconButton(
            height: height,
            icon: Icons.lock,
            color: Colors.green,
          ),
          Expanded(
            child: SizedBox(
              height: height,
              child: TextField(
                textAlign: TextAlign.center,
                onSubmitted: (string) {},
                textInputAction: TextInputAction.go,
                decoration: InputDecoration(
                  isDense: false,
                  contentPadding: const EdgeInsets.all(
                    2.0,
                  ), //マジックナンバー。縦の値に合わせて調整させたい
                  filled: true,
                  fillColor: Colors.grey[300],
                  hintText: "Search For ...",
                  hintStyle:
                      const TextStyle(color: Colors.black54, fontSize: 16.0),
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
          ),
        ],
      ),
    );
  }
}

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
