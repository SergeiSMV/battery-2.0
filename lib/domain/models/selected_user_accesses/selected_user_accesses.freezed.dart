// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'selected_user_accesses.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SelectedUserAccesses _$SelectedUserAccessesFromJson(Map<String, dynamic> json) {
  return _SelectedUserAccesses.fromJson(json);
}

/// @nodoc
mixin _$SelectedUserAccesses {
  Map<String, dynamic> get userAccesses => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SelectedUserAccessesCopyWith<SelectedUserAccesses> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectedUserAccessesCopyWith<$Res> {
  factory $SelectedUserAccessesCopyWith(SelectedUserAccesses value,
          $Res Function(SelectedUserAccesses) then) =
      _$SelectedUserAccessesCopyWithImpl<$Res, SelectedUserAccesses>;
  @useResult
  $Res call({Map<String, dynamic> userAccesses});
}

/// @nodoc
class _$SelectedUserAccessesCopyWithImpl<$Res,
        $Val extends SelectedUserAccesses>
    implements $SelectedUserAccessesCopyWith<$Res> {
  _$SelectedUserAccessesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userAccesses = null,
  }) {
    return _then(_value.copyWith(
      userAccesses: null == userAccesses
          ? _value.userAccesses
          : userAccesses // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SelectedUserAccessesCopyWith<$Res>
    implements $SelectedUserAccessesCopyWith<$Res> {
  factory _$$_SelectedUserAccessesCopyWith(_$_SelectedUserAccesses value,
          $Res Function(_$_SelectedUserAccesses) then) =
      __$$_SelectedUserAccessesCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, dynamic> userAccesses});
}

/// @nodoc
class __$$_SelectedUserAccessesCopyWithImpl<$Res>
    extends _$SelectedUserAccessesCopyWithImpl<$Res, _$_SelectedUserAccesses>
    implements _$$_SelectedUserAccessesCopyWith<$Res> {
  __$$_SelectedUserAccessesCopyWithImpl(_$_SelectedUserAccesses _value,
      $Res Function(_$_SelectedUserAccesses) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userAccesses = null,
  }) {
    return _then(_$_SelectedUserAccesses(
      userAccesses: null == userAccesses
          ? _value._userAccesses
          : userAccesses // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SelectedUserAccesses extends _SelectedUserAccesses {
  const _$_SelectedUserAccesses(
      {required final Map<String, dynamic> userAccesses})
      : _userAccesses = userAccesses,
        super._();

  factory _$_SelectedUserAccesses.fromJson(Map<String, dynamic> json) =>
      _$$_SelectedUserAccessesFromJson(json);

  final Map<String, dynamic> _userAccesses;
  @override
  Map<String, dynamic> get userAccesses {
    if (_userAccesses is EqualUnmodifiableMapView) return _userAccesses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_userAccesses);
  }

  @override
  String toString() {
    return 'SelectedUserAccesses(userAccesses: $userAccesses)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SelectedUserAccesses &&
            const DeepCollectionEquality()
                .equals(other._userAccesses, _userAccesses));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_userAccesses));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SelectedUserAccessesCopyWith<_$_SelectedUserAccesses> get copyWith =>
      __$$_SelectedUserAccessesCopyWithImpl<_$_SelectedUserAccesses>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SelectedUserAccessesToJson(
      this,
    );
  }
}

abstract class _SelectedUserAccesses extends SelectedUserAccesses {
  const factory _SelectedUserAccesses(
          {required final Map<String, dynamic> userAccesses}) =
      _$_SelectedUserAccesses;
  const _SelectedUserAccesses._() : super._();

  factory _SelectedUserAccesses.fromJson(Map<String, dynamic> json) =
      _$_SelectedUserAccesses.fromJson;

  @override
  Map<String, dynamic> get userAccesses;
  @override
  @JsonKey(ignore: true)
  _$$_SelectedUserAccessesCopyWith<_$_SelectedUserAccesses> get copyWith =>
      throw _privateConstructorUsedError;
}
