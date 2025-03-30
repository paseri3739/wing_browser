import 'package:flutter/foundation.dart';

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
