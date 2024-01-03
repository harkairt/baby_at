// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:plugger/plugger.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class SentryPlug extends Plug {
  final String dsn;

  SentryPlug({this.dsn = ''}) : assert(dsn.isNotEmpty);

  @override
  Future<void> runAppPlug(FutureOr<void> Function() appRunner) async {
    await SentryFlutter.init((options) => options.dsn = dsn);
    appRunner();
  }
}
