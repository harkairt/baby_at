// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stored_notifier/hydrated_async_notifier.dart';

part 'preferred_theme_mode_provider.g.dart';

const _mapKey = 'mapKey';

@Riverpod(keepAlive: true)
class PreferredThemeMode extends _$PreferredThemeMode with HydratedAsyncNotifier<ThemeMode> {
  @override
  FutureOr<ThemeMode> build() async => hydratedBuild((stored) => stored ?? ThemeMode.system);

  void cycleThemeMode() {
    switch (state.value) {
      case ThemeMode.system:
        state = const AsyncData(ThemeMode.light);
        break;
      case ThemeMode.light:
        state = const AsyncData(ThemeMode.dark);
        break;
      case ThemeMode.dark:
        state = const AsyncData(ThemeMode.system);
        break;
      case null:
        state = const AsyncData(ThemeMode.system);
        break;
    }
  }

  @override
  FutureOr<ThemeMode> fromJson(Map<String, dynamic> jsonValue) {
    final value = jsonValue[_mapKey] as String;
    return ThemeMode.values.firstWhere((e) => e.toString() == value);
  }

  @override
  String get key => 'themeMode';

  @override
  FutureOr<Map<String, dynamic>> toJson(ThemeMode value) {
    return {_mapKey: value.toString()};
  }
}

extension ThemeModeX on ThemeMode {
  Widget get icon {
    return Icon(iconData);
  }

  IconData get iconData {
    switch (this) {
      case ThemeMode.system:
        return Icons.brightness_auto_outlined;
      case ThemeMode.light:
        return Icons.wb_sunny_outlined;
      case ThemeMode.dark:
        return Icons.nightlight_round;
    }
  }
}
