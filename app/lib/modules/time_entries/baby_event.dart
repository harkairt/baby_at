import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:material_symbols_icons/symbols.dart';

part 'baby_event.freezed.dart';
part 'baby_event.g.dart';

@freezed
class BabyEvent with _$BabyEvent {
  const BabyEvent._();
  const factory BabyEvent({
    required String id,
    required DateTime date,
    required BabyEventType type,
  }) = _BabyEvent;

  factory BabyEvent.fromJson(Map<String, dynamic> json) => _$BabyEventFromJson(json);
}

enum BabyEventType {
  wakeUp,
  fallAsleep,
  changeDiaper,
  breastFeeding,
}

extension BabyEventTypeX on BabyEventType {
  Widget get icon {
    switch (this) {
      case BabyEventType.wakeUp:
        return Icon(iconData);
      case BabyEventType.fallAsleep:
        return Icon(iconData);
      case BabyEventType.changeDiaper:
        return Icon(iconData);
      case BabyEventType.breastFeeding:
        return Icon(iconData);
    }
  }

  IconData get iconData {
    switch (this) {
      case BabyEventType.wakeUp:
        return Icons.wb_sunny_outlined;
      case BabyEventType.fallAsleep:
        return Icons.bedtime_outlined;
      case BabyEventType.changeDiaper:
        return Icons.baby_changing_station;
      case BabyEventType.breastFeeding:
        return Symbols.breastfeeding;
    }
  }
}
