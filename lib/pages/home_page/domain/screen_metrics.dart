import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO: 比率を見直し、さらにユーザー設定できるようにする
@immutable
class ScreenMetrics {
  final double screenHeight;
  final double appBarRatio;
  final double appBarPixel;
  final double urlFieldRatio;
  final double urlFieldPixel;
  final double bottomAppBarRatio;
  final double bottomAppBarPixel;

  const ScreenMetrics({
    required this.screenHeight,
    this.appBarRatio = 0.075,
    this.urlFieldRatio = 0.03,
    this.bottomAppBarRatio = 0.075,
  })  : appBarPixel = screenHeight * appBarRatio,
        urlFieldPixel = screenHeight * urlFieldRatio,
        bottomAppBarPixel = screenHeight * bottomAppBarRatio;

  ScreenMetrics updateWith({
    double? screenHeight,
    double? appBarRatio,
    double? urlFieldRatio,
    double? bottomAppBarRatio,
  }) {
    return ScreenMetrics(
      screenHeight: screenHeight ?? this.screenHeight,
      appBarRatio: appBarRatio ?? this.appBarRatio,
      urlFieldRatio: urlFieldRatio ?? this.urlFieldRatio,
      bottomAppBarRatio: bottomAppBarRatio ?? this.bottomAppBarRatio,
    );
  }
}

class ScreenMetricsNotifier extends StateNotifier<ScreenMetrics> {
  ScreenMetricsNotifier({required double screenHeight}) : super(ScreenMetrics(screenHeight: screenHeight));

  // MediaQuery などから取得した screenHeight を更新
  void updateScreenHeight(double newHeight) {
    state = state.updateWith(screenHeight: newHeight);
  }

  // appBar の比率を更新
  void updateAppBarRatio(double newRatio) {
    state = state.updateWith(appBarRatio: newRatio);
  }

  // urlField の比率を更新
  void updateUrlFieldRatio(double newRatio) {
    state = state.updateWith(urlFieldRatio: newRatio);
  }

  // bottomAppBar の比率を更新
  void updateBottomAppBarRatio(double newRatio) {
    state = state.updateWith(bottomAppBarRatio: newRatio);
  }
}

// 初期値はウィジェット側で MediaQuery から取得するため、仮の値(例:0)を設定しておく
final screenMetricsProvider = StateNotifierProvider<ScreenMetricsNotifier, ScreenMetrics>((ref) {
  return ScreenMetricsNotifier(screenHeight: 0);
});
