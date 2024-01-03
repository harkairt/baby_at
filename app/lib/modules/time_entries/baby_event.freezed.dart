// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'baby_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BabyEvent _$BabyEventFromJson(Map<String, dynamic> json) {
  return _BabyEvent.fromJson(json);
}

/// @nodoc
mixin _$BabyEvent {
  String get id => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  BabyEventType get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BabyEventCopyWith<BabyEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BabyEventCopyWith<$Res> {
  factory $BabyEventCopyWith(BabyEvent value, $Res Function(BabyEvent) then) =
      _$BabyEventCopyWithImpl<$Res, BabyEvent>;
  @useResult
  $Res call({String id, DateTime date, BabyEventType type});
}

/// @nodoc
class _$BabyEventCopyWithImpl<$Res, $Val extends BabyEvent>
    implements $BabyEventCopyWith<$Res> {
  _$BabyEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as BabyEventType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BabyEventImplCopyWith<$Res>
    implements $BabyEventCopyWith<$Res> {
  factory _$$BabyEventImplCopyWith(
          _$BabyEventImpl value, $Res Function(_$BabyEventImpl) then) =
      __$$BabyEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, DateTime date, BabyEventType type});
}

/// @nodoc
class __$$BabyEventImplCopyWithImpl<$Res>
    extends _$BabyEventCopyWithImpl<$Res, _$BabyEventImpl>
    implements _$$BabyEventImplCopyWith<$Res> {
  __$$BabyEventImplCopyWithImpl(
      _$BabyEventImpl _value, $Res Function(_$BabyEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? type = null,
  }) {
    return _then(_$BabyEventImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as BabyEventType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BabyEventImpl extends _BabyEvent {
  const _$BabyEventImpl(
      {required this.id, required this.date, required this.type})
      : super._();

  factory _$BabyEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$BabyEventImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime date;
  @override
  final BabyEventType type;

  @override
  String toString() {
    return 'BabyEvent(id: $id, date: $date, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BabyEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, date, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BabyEventImplCopyWith<_$BabyEventImpl> get copyWith =>
      __$$BabyEventImplCopyWithImpl<_$BabyEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BabyEventImplToJson(
      this,
    );
  }
}

abstract class _BabyEvent extends BabyEvent {
  const factory _BabyEvent(
      {required final String id,
      required final DateTime date,
      required final BabyEventType type}) = _$BabyEventImpl;
  const _BabyEvent._() : super._();

  factory _BabyEvent.fromJson(Map<String, dynamic> json) =
      _$BabyEventImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get date;
  @override
  BabyEventType get type;
  @override
  @JsonKey(ignore: true)
  _$$BabyEventImplCopyWith<_$BabyEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
