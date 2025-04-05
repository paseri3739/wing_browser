import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wing_browser/domain/web_view_model.dart';

class ProgressBar extends ConsumerWidget {
  const ProgressBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(webViewStateProvider).loadingProgress.progress;
    return Visibility(
        visible: progress > 0,
        child: LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.white,
        ));
  }
}
