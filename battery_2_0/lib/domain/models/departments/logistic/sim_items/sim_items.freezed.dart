// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sim_items.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SimItems _$SimItemsFromJson(Map<String, dynamic> json) {
  return _SimItems.fromJson(json);
}

/// @nodoc
mixin _$SimItems {
  Map<dynamic, dynamic> get item => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SimItemsCopyWith<SimItems> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SimItemsCopyWith<$Res> {
  factory $SimItemsCopyWith(SimItems value, $Res Function(SimItems) then) =
      _$SimItemsCopyWithImpl<$Res, SimItems>;
  @useResult
  $Res call({Map<dynamic, dynamic> item});
}

/// @nodoc
class _$SimItemsCopyWithImpl<$Res, $Val extends SimItems>
    implements $SimItemsCopyWith<$Res> {
  _$SimItemsCopyWithImpl(this._value, this._then);

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
abstract class _$$_SimItemsCopyWith<$Res> implements $SimItemsCopyWith<$Res> {
  factory _$$_SimItemsCopyWith(
          _$_SimItems value, $Res Function(_$_SimItems) then) =
      __$$_SimItemsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<dynamic, dynamic> item});
}

/// @nodoc
class __$$_SimItemsCopyWithImpl<$Res>
    extends _$SimItemsCopyWithImpl<$Res, _$_SimItems>
    implements _$$_SimItemsCopyWith<$Res> {
  __$$_SimItemsCopyWithImpl(
      _$_SimItems _value, $Res Function(_$_SimItems) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = null,
  }) {
    return _then(_$_SimItems(
      item: null == item
          ? _value._item
          : item // ignore: cast_nullable_to_non_nullable
              as Map<dynamic, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SimItems extends _SimItems {
  const _$_SimItems({required final Map<dynamic, dynamic> item})
      : _item = item,
        super._();

  factory _$_SimItems.fromJson(Map<String, dynamic> json) =>
      _$$_SimItemsFromJson(json);

  final Map<dynamic, dynamic> _item;
  @override
  Map<dynamic, dynamic> get item {
    if (_item is EqualUnmodifiableMapView) return _item;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_item);
  }

  @override
  String toString() {
    return 'SimItems(item: $item)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SimItems &&
            const DeepCollectionEquality().equals(other._item, _item));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_item));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SimItemsCopyWith<_$_SimItems> get copyWith =>
      __$$_SimItemsCopyWithImpl<_$_SimItems>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SimItemsToJson(
      this,
    );
  }
}

abstract class _SimItems extends SimItems {
  const factory _SimItems({required final Map<dynamic, dynamic> item}) =
      _$_SimItems;
  const _SimItems._() : super._();

  factory _SimItems.fromJson(Map<String, dynamic> json) = _$_SimItems.fromJson;

  @override
  Map<dynamic, dynamic> get item;
  @override
  @JsonKey(ignore: true)
  _$$_SimItemsCopyWith<_$_SimItems> get copyWith =>
      throw _privateConstructorUsedError;
}
