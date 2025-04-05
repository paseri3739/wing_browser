import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wing_browser/domain/web_view_model.dart';

class ProgressBar extends ConsumerWidget {
  const ProgressBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final webViewState = ref.watch(webViewStateProvider);
    final progress = webViewState.loadingProgress.progress;
    return Visibility(
        visible: webViewState.isLoading,
        child: LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.white,
        ));
  }
}
