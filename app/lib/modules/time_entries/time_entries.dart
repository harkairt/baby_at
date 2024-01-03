import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'time_entries.g.dart';

@riverpod
class TimeEntries extends _$TimeEntries {
  @override
  FutureOr<List<DateTime>> build() async {
    return [];
  }
}
