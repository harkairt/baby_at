import 'package:app/modules/time_entries/baby_event.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stored_notifier/hydrated_async_notifier.dart';
import 'package:uuid/uuid.dart';

part 'baby_events.g.dart';

const _mapKey = 'mapKey';

@Riverpod(keepAlive: true)
class BabyEvents extends _$BabyEvents with HydratedAsyncNotifier<List<BabyEvent>> {
  @override
  FutureOr<List<BabyEvent>> build() async {
    return hydratedBuild((stored) => stored ?? []);
  }

  @override
  FutureOr<List<BabyEvent>> fromJson(Map<String, dynamic> jsonValue) {
    final json = (jsonValue[_mapKey] as List<dynamic>).cast<Map<String, dynamic>>();
    return json.map((e) => BabyEvent.fromJson(e)).toList();
  }

  @override
  String get key => 'events';

  @override
  FutureOr<Map<String, dynamic>> toJson(List<BabyEvent> value) {
    return {_mapKey: value.map((e) => e.toJson()).toList()};
  }

  void add(BabyEventType type) {
    final event = BabyEvent(
      id: const Uuid().v4(),
      date: DateTime.now(),
      type: type,
    );

    state = state.whenData((value) => [...value, event]);
  }

  void remove(String id) {
    state = state.whenData((value) => [...value].where((e) => e.id != id).toList());
  }
}
