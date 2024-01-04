import 'package:app/modules/time_entries/baby_event.dart';
import 'package:app/modules/time_entries/baby_events.dart';
import 'package:app/modules/time_entries/now_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'awake_since.g.dart';

@riverpod
FutureOr<Duration?> awakeSince(AwakeSinceRef ref) async {
  final events = await ref.watch(babyEventsProvider.future);

  final sleepEvents = events.where((e) => e.type == BabyEventType.fallAsleep || e.type == BabyEventType.wakeUp);
  final lastEvent = sleepEvents.lastOrNull;

  if (lastEvent == null || lastEvent.type == BabyEventType.fallAsleep) {
    return null;
  }

  final now = ref.watch(nowProvider);

  return now.difference(lastEvent.date);
}
