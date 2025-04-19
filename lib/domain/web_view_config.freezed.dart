// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'web_view_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WebViewConfig implements DiagnosticableTreeMixin {
  InAppWebViewSettings get settings;
  PullToRefreshSettings get pullToRefreshSettings;
  WebUri get initialUrl;

  /// Create a copy of WebViewConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WebViewConfigCopyWith<WebViewConfig> get copyWith =>
      _$WebViewConfigCopyWithImpl<WebViewConfig>(
          this as WebViewConfig, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'WebViewConfig'))
      ..add(DiagnosticsProperty('settings', settings))
      ..add(DiagnosticsProperty('pullToRefreshSettings', pullToRefreshSettings))
      ..add(DiagnosticsProperty('initialUrl', initialUrl));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WebViewConfig &&
            (identical(other.settings, settings) ||
                other.settings == settings) &&
            (identical(other.pullToRefreshSettings, pullToRefreshSettings) ||
                other.pullToRefreshSettings == pullToRefreshSettings) &&
            (identical(other.initialUrl, initialUrl) ||
                other.initialUrl == initialUrl));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, settings, pullToRefreshSettings, initialUrl);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WebViewConfig(settings: $settings, pullToRefreshSettings: $pullToRefreshSettings, initialUrl: $initialUrl)';
  }
}

/// @nodoc
abstract mixin class $WebViewConfigCopyWith<$Res> {
  factory $WebViewConfigCopyWith(
          WebViewConfig value, $Res Function(WebViewConfig) _then) =
      _$WebViewConfigCopyWithImpl;
  @useResult
  $Res call(
      {InAppWebViewSettings settings,
      PullToRefreshSettings pullToRefreshSettings,
      WebUri initialUrl});
}

/// @nodoc
class _$WebViewConfigCopyWithImpl<$Res>
    implements $WebViewConfigCopyWith<$Res> {
  _$WebViewConfigCopyWithImpl(this._self, this._then);

  final WebViewConfig _self;
  final $Res Function(WebViewConfig) _then;

  /// Create a copy of WebViewConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? settings = null,
    Object? pullToRefreshSettings = null,
    Object? initialUrl = null,
  }) {
    return _then(_self.copyWith(
      settings: null == settings
          ? _self.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as InAppWebViewSettings,
      pullToRefreshSettings: null == pullToRefreshSettings
          ? _self.pullToRefreshSettings
          : pullToRefreshSettings // ignore: cast_nullable_to_non_nullable
              as PullToRefreshSettings,
      initialUrl: null == initialUrl
          ? _self.initialUrl
          : initialUrl // ignore: cast_nullable_to_non_nullable
              as WebUri,
    ));
  }
}

/// @nodoc

class _WebViewConfig with DiagnosticableTreeMixin implements WebViewConfig {
  const _WebViewConfig(
      {required this.settings,
      required this.pullToRefreshSettings,
      required this.initialUrl});

  @override
  final InAppWebViewSettings settings;
  @override
  final PullToRefreshSettings pullToRefreshSettings;
  @override
  final WebUri initialUrl;

  /// Create a copy of WebViewConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WebViewConfigCopyWith<_WebViewConfig> get copyWith =>
      __$WebViewConfigCopyWithImpl<_WebViewConfig>(this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'WebViewConfig'))
      ..add(DiagnosticsProperty('settings', settings))
      ..add(DiagnosticsProperty('pullToRefreshSettings', pullToRefreshSettings))
      ..add(DiagnosticsProperty('initialUrl', initialUrl));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WebViewConfig &&
            (identical(other.settings, settings) ||
                other.settings == settings) &&
            (identical(other.pullToRefreshSettings, pullToRefreshSettings) ||
                other.pullToRefreshSettings == pullToRefreshSettings) &&
            (identical(other.initialUrl, initialUrl) ||
                other.initialUrl == initialUrl));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, settings, pullToRefreshSettings, initialUrl);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WebViewConfig(settings: $settings, pullToRefreshSettings: $pullToRefreshSettings, initialUrl: $initialUrl)';
  }
}

/// @nodoc
abstract mixin class _$WebViewConfigCopyWith<$Res>
    implements $WebViewConfigCopyWith<$Res> {
  factory _$WebViewConfigCopyWith(
          _WebViewConfig value, $Res Function(_WebViewConfig) _then) =
      __$WebViewConfigCopyWithImpl;
  @override
  @useResult
  $Res call(
      {InAppWebViewSettings settings,
      PullToRefreshSettings pullToRefreshSettings,
      WebUri initialUrl});
}

/// @nodoc
class __$WebViewConfigCopyWithImpl<$Res>
    implements _$WebViewConfigCopyWith<$Res> {
  __$WebViewConfigCopyWithImpl(this._self, this._then);

  final _WebViewConfig _self;
  final $Res Function(_WebViewConfig) _then;

  /// Create a copy of WebViewConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? settings = null,
    Object? pullToRefreshSettings = null,
    Object? initialUrl = null,
  }) {
    return _then(_WebViewConfig(
      settings: null == settings
          ? _self.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as InAppWebViewSettings,
      pullToRefreshSettings: null == pullToRefreshSettings
          ? _self.pullToRefreshSettings
          : pullToRefreshSettings // ignore: cast_nullable_to_non_nullable
              as PullToRefreshSettings,
      initialUrl: null == initialUrl
          ? _self.initialUrl
          : initialUrl // ignore: cast_nullable_to_non_nullable
              as WebUri,
    ));
  }
}

// dart format on
