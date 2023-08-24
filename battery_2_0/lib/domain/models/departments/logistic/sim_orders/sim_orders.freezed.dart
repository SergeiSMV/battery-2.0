// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sim_orders.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SimOrders _$SimOrdersFromJson(Map<String, dynamic> json) {
  return _SimOrders.fromJson(json);
}

/// @nodoc
mixin _$SimOrders {
  Map<dynamic, dynamic> get orders => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SimOrdersCopyWith<SimOrders> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SimOrdersCopyWith<$Res> {
  factory $SimOrdersCopyWith(SimOrders value, $Res Function(SimOrders) then) =
      _$SimOrdersCopyWithImpl<$Res, SimOrders>;
  @useResult
  $Res call({Map<dynamic, dynamic> orders});
}

/// @nodoc
class _$SimOrdersCopyWithImpl<$Res, $Val extends SimOrders>
    implements $SimOrdersCopyWith<$Res> {
  _$SimOrdersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orders = null,
  }) {
    return _then(_value.copyWith(
      orders: null == orders
          ? _value.orders
          : orders // ignore: cast_nullable_to_non_nullable
              as Map<dynamic, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SimOrdersCopyWith<$Res> implements $SimOrdersCopyWith<$Res> {
  factory _$$_SimOrdersCopyWith(
          _$_SimOrders value, $Res Function(_$_SimOrders) then) =
      __$$_SimOrdersCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<dynamic, dynamic> orders});
}

/// @nodoc
class __$$_SimOrdersCopyWithImpl<$Res>
    extends _$SimOrdersCopyWithImpl<$Res, _$_SimOrders>
    implements _$$_SimOrdersCopyWith<$Res> {
  __$$_SimOrdersCopyWithImpl(
      _$_SimOrders _value, $Res Function(_$_SimOrders) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orders = null,
  }) {
    return _then(_$_SimOrders(
      orders: null == orders
          ? _value._orders
          : orders // ignore: cast_nullable_to_non_nullable
              as Map<dynamic, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SimOrders extends _SimOrders {
  const _$_SimOrders({required final Map<dynamic, dynamic> orders})
      : _orders = orders,
        super._();

  factory _$_SimOrders.fromJson(Map<String, dynamic> json) =>
      _$$_SimOrdersFromJson(json);

  final Map<dynamic, dynamic> _orders;
  @override
  Map<dynamic, dynamic> get orders {
    if (_orders is EqualUnmodifiableMapView) return _orders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_orders);
  }

  @override
  String toString() {
    return 'SimOrders(orders: $orders)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SimOrders &&
            const DeepCollectionEquality().equals(other._orders, _orders));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_orders));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SimOrdersCopyWith<_$_SimOrders> get copyWith =>
      __$$_SimOrdersCopyWithImpl<_$_SimOrders>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SimOrdersToJson(
      this,
    );
  }
}

abstract class _SimOrders extends SimOrders {
  const factory _SimOrders({required final Map<dynamic, dynamic> orders}) =
      _$_SimOrders;
  const _SimOrders._() : super._();

  factory _SimOrders.fromJson(Map<String, dynamic> json) =
      _$_SimOrders.fromJson;

  @override
  Map<dynamic, dynamic> get orders;
  @override
  @JsonKey(ignore: true)
  _$$_SimOrdersCopyWith<_$_SimOrders> get copyWith =>
      throw _privateConstructorUsedError;
}
