// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sim_same_items.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SimSameItems _$SimSameItemsFromJson(Map<String, dynamic> json) {
  return _SimSameItems.fromJson(json);
}

/// @nodoc
mixin _$SimSameItems {
  Map<dynamic, dynamic> get sameItem => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SimSameItemsCopyWith<SimSameItems> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SimSameItemsCopyWith<$Res> {
  factory $SimSameItemsCopyWith(
          SimSameItems value, $Res Function(SimSameItems) then) =
      _$SimSameItemsCopyWithImpl<$Res, SimSameItems>;
  @useResult
  $Res call({Map<dynamic, dynamic> sameItem});
}

/// @nodoc
class _$SimSameItemsCopyWithImpl<$Res, $Val extends SimSameItems>
    implements $SimSameItemsCopyWith<$Res> {
  _$SimSameItemsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sameItem = null,
  }) {
    return _then(_value.copyWith(
      sameItem: null == sameItem
          ? _value.sameItem
          : sameItem // ignore: cast_nullable_to_non_nullable
              as Map<dynamic, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SimSameItemsCopyWith<$Res>
    implements $SimSameItemsCopyWith<$Res> {
  factory _$$_SimSameItemsCopyWith(
          _$_SimSameItems value, $Res Function(_$_SimSameItems) then) =
      __$$_SimSameItemsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<dynamic, dynamic> sameItem});
}

/// @nodoc
class __$$_SimSameItemsCopyWithImpl<$Res>
    extends _$SimSameItemsCopyWithImpl<$Res, _$_SimSameItems>
    implements _$$_SimSameItemsCopyWith<$Res> {
  __$$_SimSameItemsCopyWithImpl(
      _$_SimSameItems _value, $Res Function(_$_SimSameItems) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sameItem = null,
  }) {
    return _then(_$_SimSameItems(
      sameItem: null == sameItem
          ? _value._sameItem
          : sameItem // ignore: cast_nullable_to_non_nullable
              as Map<dynamic, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SimSameItems extends _SimSameItems {
  const _$_SimSameItems({required final Map<dynamic, dynamic> sameItem})
      : _sameItem = sameItem,
        super._();

  factory _$_SimSameItems.fromJson(Map<String, dynamic> json) =>
      _$$_SimSameItemsFromJson(json);

  final Map<dynamic, dynamic> _sameItem;
  @override
  Map<dynamic, dynamic> get sameItem {
    if (_sameItem is EqualUnmodifiableMapView) return _sameItem;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_sameItem);
  }

  @override
  String toString() {
    return 'SimSameItems(sameItem: $sameItem)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SimSameItems &&
            const DeepCollectionEquality().equals(other._sameItem, _sameItem));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_sameItem));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SimSameItemsCopyWith<_$_SimSameItems> get copyWith =>
      __$$_SimSameItemsCopyWithImpl<_$_SimSameItems>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SimSameItemsToJson(
      this,
    );
  }
}

abstract class _SimSameItems extends SimSameItems {
  const factory _SimSameItems({required final Map<dynamic, dynamic> sameItem}) =
      _$_SimSameItems;
  const _SimSameItems._() : super._();

  factory _SimSameItems.fromJson(Map<String, dynamic> json) =
      _$_SimSameItems.fromJson;

  @override
  Map<dynamic, dynamic> get sameItem;
  @override
  @JsonKey(ignore: true)
  _$$_SimSameItemsCopyWith<_$_SimSameItems> get copyWith =>
      throw _privateConstructorUsedError;
}
