// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sim_order_items.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SimOrderItems _$SimOrderItemsFromJson(Map<String, dynamic> json) {
  return _SimOrderItems.fromJson(json);
}

/// @nodoc
mixin _$SimOrderItems {
  Map<dynamic, dynamic> get item => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SimOrderItemsCopyWith<SimOrderItems> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SimOrderItemsCopyWith<$Res> {
  factory $SimOrderItemsCopyWith(
          SimOrderItems value, $Res Function(SimOrderItems) then) =
      _$SimOrderItemsCopyWithImpl<$Res, SimOrderItems>;
  @useResult
  $Res call({Map<dynamic, dynamic> item});
}

/// @nodoc
class _$SimOrderItemsCopyWithImpl<$Res, $Val extends SimOrderItems>
    implements $SimOrderItemsCopyWith<$Res> {
  _$SimOrderItemsCopyWithImpl(this._value, this._then);

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
abstract class _$$_SimOrderItemsCopyWith<$Res>
    implements $SimOrderItemsCopyWith<$Res> {
  factory _$$_SimOrderItemsCopyWith(
          _$_SimOrderItems value, $Res Function(_$_SimOrderItems) then) =
      __$$_SimOrderItemsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<dynamic, dynamic> item});
}

/// @nodoc
class __$$_SimOrderItemsCopyWithImpl<$Res>
    extends _$SimOrderItemsCopyWithImpl<$Res, _$_SimOrderItems>
    implements _$$_SimOrderItemsCopyWith<$Res> {
  __$$_SimOrderItemsCopyWithImpl(
      _$_SimOrderItems _value, $Res Function(_$_SimOrderItems) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = null,
  }) {
    return _then(_$_SimOrderItems(
      item: null == item
          ? _value._item
          : item // ignore: cast_nullable_to_non_nullable
              as Map<dynamic, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SimOrderItems extends _SimOrderItems {
  const _$_SimOrderItems({required final Map<dynamic, dynamic> item})
      : _item = item,
        super._();

  factory _$_SimOrderItems.fromJson(Map<String, dynamic> json) =>
      _$$_SimOrderItemsFromJson(json);

  final Map<dynamic, dynamic> _item;
  @override
  Map<dynamic, dynamic> get item {
    if (_item is EqualUnmodifiableMapView) return _item;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_item);
  }

  @override
  String toString() {
    return 'SimOrderItems(item: $item)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SimOrderItems &&
            const DeepCollectionEquality().equals(other._item, _item));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_item));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SimOrderItemsCopyWith<_$_SimOrderItems> get copyWith =>
      __$$_SimOrderItemsCopyWithImpl<_$_SimOrderItems>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SimOrderItemsToJson(
      this,
    );
  }
}

abstract class _SimOrderItems extends SimOrderItems {
  const factory _SimOrderItems({required final Map<dynamic, dynamic> item}) =
      _$_SimOrderItems;
  const _SimOrderItems._() : super._();

  factory _SimOrderItems.fromJson(Map<String, dynamic> json) =
      _$_SimOrderItems.fromJson;

  @override
  Map<dynamic, dynamic> get item;
  @override
  @JsonKey(ignore: true)
  _$$_SimOrderItemsCopyWith<_$_SimOrderItems> get copyWith =>
      throw _privateConstructorUsedError;
}
