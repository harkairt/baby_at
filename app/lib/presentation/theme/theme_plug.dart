// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:app/presentation/theme/preferred_theme_mode_provider.dart';
import 'package:app/presentation/widgets/avb.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plugger/plugger.dart';

class ThemePlug extends Plug {
  final ThemeData? highContrastTheme;
  final ThemeData? highContrastDarkTheme;
  final Duration themeAnimationDuration;
  final Curve themeAnimationCurve;

  ThemePlug({
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.themeAnimationDuration = kThemeAnimationDuration,
    this.themeAnimationCurve = Curves.linear,
  });

  ThemeData get theme => FlexThemeData.light(scheme: FlexScheme.purpleBrown, useMaterial3: true)
      .copyWith(buttonTheme: const ButtonThemeData(minWidth: 300))
      .copyWith(filledButtonTheme: const FilledButtonThemeData());

  ThemeData? get darkTheme => FlexThemeData.dark(scheme: FlexScheme.ebonyClay, useMaterial3: true);

  @override
  Widget navigatorPlug(BuildContext context, Widget child) {
    return Consumer(
      builder: (context, ref, _) {
        return AVB(
          value: ref.watch(preferredThemeModeProvider),
          available: (context, value, isLoading) {
            return AnimatedTheme(
              data: _themeBuilder(context, ref.watch(preferredThemeModeProvider).valueOrNull ?? ThemeMode.system),
              duration: themeAnimationDuration,
              curve: themeAnimationCurve,
              child: child,
            );
          },
        );
      },
    );
  }

  ThemeData _themeBuilder(BuildContext context, ThemeMode mode) {
    ThemeData? _theme;
    final Brightness platformBrightness = MediaQuery.platformBrightnessOf(context);
    final bool useDarkTheme =
        mode == ThemeMode.dark || (mode == ThemeMode.system && platformBrightness == Brightness.dark);
    final bool highContrast = MediaQuery.highContrastOf(context);
    if (useDarkTheme && highContrast && highContrastDarkTheme != null) {
      _theme = highContrastDarkTheme;
    } else if (useDarkTheme && darkTheme != null) {
      _theme = darkTheme;
    } else if (highContrast && highContrastTheme != null) {
      _theme = highContrastTheme;
    }
    _theme ??= theme;
    return _theme;
  }
}
