import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'now_provider.g.dart';

@riverpod
DateTime now(NowRef ref) {
  ref.refreshEvery(const Duration(seconds: 1));

  return DateTime.now();
}

extension RefX on Ref {
  void refreshEvery(Duration duration) {
    final timer = Timer.periodic(duration, (_) => invalidateSelf());
    onDispose(timer.cancel);
  }
}
