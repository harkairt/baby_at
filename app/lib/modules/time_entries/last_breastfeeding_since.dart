import 'package:app/modules/time_entries/baby_event.dart';
import 'package:app/modules/time_entries/baby_events.dart';
import 'package:app/modules/time_entries/now_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:collection/collection.dart';

part 'last_breastfeeding_since.g.dart';

@riverpod
FutureOr<Duration?> lastBreastfeedingSince(LastBreastfeedingSinceRef ref) async {
  final events = await ref.watch(babyEventsProvider.future);

  final lastBreastfeeding = events.lastWhereOrNull((element) => element.type == BabyEventType.breastfeeding);

  if (lastBreastfeeding == null) {
    return null;
  }

  final now = ref.watch(nowProvider);

  return now.difference(lastBreastfeeding.date);
}
