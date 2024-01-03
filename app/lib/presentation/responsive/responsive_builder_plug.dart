import 'dart:async';

import 'package:flutter/material.dart';
import 'package:plugger/plugger.dart';
import 'package:responsive_builder/responsive_builder.dart';

const kWatchWidth = 1.0;
const kMobileWidth = 480.0;
const kTabletWidth = 768.0;

class ResponsiveBuilderPlug extends Plug {
  @override
  FutureOr<void> runAppPlug(FutureOr<void> Function() appRunner) {
    ResponsiveSizingConfig.instance.setCustomBreakpoints(
      const ScreenBreakpoints(
        desktop: kTabletWidth,
        tablet: kMobileWidth,
        watch: kWatchWidth,
      ),
    );

    return super.runAppPlug(appRunner);
  }

  @override
  PlugWiring appPlug() => PlugWiring(
        (child) => ResponsiveApp(
          preferDesktop: true,
          builder: (context) => child,
        ),
      );
}

extension BuildContextX on BuildContext {
  T screenValue<T>({
    required T mobile,
    T? tablet,
    T? desktop,
    T? watch,
    T? orElse,
  }) =>
      getValueForScreenType(
        context: this,
        mobile: mobile,
        tablet: tablet ?? orElse,
        desktop: desktop ?? orElse,
        watch: watch ?? orElse,
      );
}
