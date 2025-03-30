import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wing_browser/ui_components/top_navigation/domain/url_field_model.dart';

class UrlTextField extends ConsumerWidget {
  final TextEditingController controller;
  final double height;
  final InAppWebViewController webViewController;

  const UrlTextField({
    super.key,
    required this.controller,
    required this.height,
    required this.webViewController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    return Expanded(
      child: SizedBox(
        height: height,
        child: TextField(
          controller: controller,
          textAlign: TextAlign.center,
          onSubmitted: (string) async {
            if (webViewController != null) {
              // TODO: これを随所に書かなくて済むようにドメイン層を設計する。
              await UrlFieldModel.onSubmitted(string, webViewController, ref, context);
            }
          },
          textInputAction: TextInputAction.go,
          decoration: InputDecoration(
            isDense: false,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 16.0,
            ),
            filled: true,
            fillColor: Colors.grey[300],
            hintText: "Search For ...",
            hintStyle: const TextStyle(color: Colors.black54, fontSize: 16.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3.0),
              borderSide: BorderSide.none,
            ),
          ),
          style: const TextStyle(color: Colors.black, fontSize: 16.0),
        ),
      ),
    );
  }
}
