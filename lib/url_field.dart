import 'package:flutter/material.dart';

class UrlField extends StatelessWidget {
  const UrlField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 40.0,
        width: 400,
        child: TextField(
          onSubmitted: (string) {},
          textInputAction: TextInputAction.go,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(10.0),
            filled: true,
            fillColor: Colors.white,
            hintText: "Search For ...",
            hintStyle: TextStyle(color: Colors.black54, fontSize: 16.0),
          ),
          style: const TextStyle(color: Colors.black, fontSize: 16.0),
        ));
  }
}
