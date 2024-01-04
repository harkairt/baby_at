import 'package:app/modules/time_entries/baby_event.dart';
import 'package:app/modules/time_entries/baby_events.dart';
import 'package:app/modules/time_entries/now_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:collection/collection.dart';

part 'last_diaper_change_since.g.dart';

@riverpod
FutureOr<Duration?> lastDiaperChangeSince(LastDiaperChangeSinceRef ref) async {
  final events = await ref.watch(babyEventsProvider.future);

  final lastDiaperChange = events.lastWhereOrNull((element) => element.type == BabyEventType.changeDiaper);

  if (lastDiaperChange == null) {
    return null;
  }

  final now = ref.watch(nowProvider);

  return now.difference(lastDiaperChange.date);
}
