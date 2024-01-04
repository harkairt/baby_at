import 'package:app/modules/time_entries/baby_event.dart';
import 'package:app/modules/time_entries/baby_events.dart';
import 'package:app/modules/time_entries/now_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'asleep_since.g.dart';

@riverpod
FutureOr<Duration?> asleepSince(AsleepSinceRef ref) async {
  final events = await ref.watch(babyEventsProvider.future);

  final sleepEvents = events.where((e) => e.type == BabyEventType.fallAsleep || e.type == BabyEventType.wakeUp);
  final lastEvent = sleepEvents.last;

  if (lastEvent.type == BabyEventType.wakeUp) {
    return null;
  }

  final now = ref.watch(nowProvider);

  return now.difference(lastEvent.date);
}
