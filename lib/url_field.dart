import 'package:flutter/material.dart';

class UrlField extends StatelessWidget {
  const UrlField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.lock), // 鍵マークのアイコン
          onPressed: () {
            // 鍵マークのボタンが押された時の処理
          },
        ),
        Expanded(
          child: SizedBox(
            height: 40.0,
            child: TextField(
              onSubmitted: (string) {
                // ユーザーが入力を完了して送信ボタンを押した時の処理
              },
              textInputAction: TextInputAction.go,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10.0),
                filled: true,
                fillColor: Colors.grey[300], // テキストフィールドをグレーに設定
                hintText: "Search For ...",
                hintStyle:
                    const TextStyle(color: Colors.black54, fontSize: 16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide.none, // 枠線を非表示に設定
                ),
              ),
              style: const TextStyle(color: Colors.black, fontSize: 16.0),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.refresh), // 更新マークのアイコン
          onPressed: () {
            // 更新マークのボタンが押された時の処理
          },
        ),
      ],
    );
  }
}
