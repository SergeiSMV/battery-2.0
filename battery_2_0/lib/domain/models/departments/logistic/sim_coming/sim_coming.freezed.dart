// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sim_coming.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SimComing _$SimComingFromJson(Map<String, dynamic> json) {
  return _SimComing.fromJson(json);
}

/// @nodoc
mixin _$SimComing {
  Map<dynamic, dynamic> get item => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SimComingCopyWith<SimComing> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SimComingCopyWith<$Res> {
  factory $SimComingCopyWith(SimComing value, $Res Function(SimComing) then) =
      _$SimComingCopyWithImpl<$Res, SimComing>;
  @useResult
  $Res call({Map<dynamic, dynamic> item});
}

/// @nodoc
class _$SimComingCopyWithImpl<$Res, $Val extends SimComing>
    implements $SimComingCopyWith<$Res> {
  _$SimComingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = null,
  }) {
    return _then(_value.copyWith(
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as Map<dynamic, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SimComingCopyWith<$Res> implements $SimComingCopyWith<$Res> {
  factory _$$_SimComingCopyWith(
          _$_SimComing value, $Res Function(_$_SimComing) then) =
      __$$_SimComingCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<dynamic, dynamic> item});
}

/// @nodoc
class __$$_SimComingCopyWithImpl<$Res>
    extends _$SimComingCopyWithImpl<$Res, _$_SimComing>
    implements _$$_SimComingCopyWith<$Res> {
  __$$_SimComingCopyWithImpl(
      _$_SimComing _value, $Res Function(_$_SimComing) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = null,
  }) {
    return _then(_$_SimComing(
      item: null == item
          ? _value._item
          : item // ignore: cast_nullable_to_non_nullable
              as Map<dynamic, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SimComing extends _SimComing {
  const _$_SimComing({required final Map<dynamic, dynamic> item})
      : _item = item,
        super._();

  factory _$_SimComing.fromJson(Map<String, dynamic> json) =>
      _$$_SimComingFromJson(json);

  final Map<dynamic, dynamic> _item;
  @override
  Map<dynamic, dynamic> get item {
    if (_item is EqualUnmodifiableMapView) return _item;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_item);
  }

  @override
  String toString() {
    return 'SimComing(item: $item)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SimComing &&
            const DeepCollectionEquality().equals(other._item, _item));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_item));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SimComingCopyWith<_$_SimComing> get copyWith =>
      __$$_SimComingCopyWithImpl<_$_SimComing>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SimComingToJson(
      this,
    );
  }
}

abstract class _SimComing extends SimComing {
  const factory _SimComing({required final Map<dynamic, dynamic> item}) =
      _$_SimComing;
  const _SimComing._() : super._();

  factory _SimComing.fromJson(Map<String, dynamic> json) =
      _$_SimComing.fromJson;

  @override
  Map<dynamic, dynamic> get item;
  @override
  @JsonKey(ignore: true)
  _$$_SimComingCopyWith<_$_SimComing> get copyWith =>
      throw _privateConstructorUsedError;
}
