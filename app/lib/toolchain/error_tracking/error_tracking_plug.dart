// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:plugger/plugger.dart';
import 'package:stack_trace/stack_trace.dart';

class ErrorTrackingPlug extends Plug {
  ErrorTrackingPlug({this.onError});

  void Function(Object error, Chain chain)? onError;

  @override
  Future<void> runAppPlug(FutureOr<void> Function() appRunner) async {
    // https://stackoverflow.com/questions/73591769/got-a-stack-frame-from-packagestack-trace-where-a-vm-or-web-frame-was-expected
    FlutterError.demangleStackTrace = (StackTrace stack) {
      StackTrace _stack;

      _stack = stack;
      if (stack is Trace) _stack = stack.vmTrace;
      if (stack is Chain) _stack = stack.toTrace().vmTrace;
      return _stack;
    };

    Chain.capture(
      () => appRunner(),
      onError: onError,
    );
  }
}

extension StackTraceX on StackTrace {
  StackTrace replaceAll(String regexp, String replace) {
    final lines = toString().split('\n');
    return StackTrace.fromString(lines.map((e) => e.replaceAll(regexp, replace)).join('\n'));
  }

  StackTrace get sanitized {
    final blacklist = [
      '.g.dart',
      'dart-sdk',
      'rxdart',
      'async_patch',
      'stack_zone_specification',
      'packages/stack_trace',
      'packages/ferry',
      'packages/flutter',
      'packages/riverpod',
      'lib/_engine/engine',
      'stack_zone_specification',
    ];

    final trace = Chain.forTrace(Trace.from(this)).toTrace();
    final filtered = trace.frames.where((f) => blacklist.every((b) => !f.location.contains(b))).toList();
    final parsed = Trace.parse(filtered.fold('', (prev, f) => '$prev\n${f.location} ${f.member}'));

    return parsed.original.replaceAll('packages/app/', 'lib/');
  }
}

Future<dynamic> showcaseStack() async {
  await Future<void>.delayed(const Duration(milliseconds: 100));
  await _b();
}

Future<dynamic> _b() async {
  await Future<void>.delayed(const Duration(milliseconds: 100));
  await _c();
}

Future<dynamic> _c() async {
  await Future<void>.delayed(const Duration(milliseconds: 100));
  await _d();
}

Future<dynamic> _d() async {
  await Future<void>.delayed(const Duration(milliseconds: 100));
  throw "up";
}
