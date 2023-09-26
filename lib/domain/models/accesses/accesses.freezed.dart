// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'accesses.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Accesses _$AccessesFromJson(Map<String, dynamic> json) {
  return _Accesses.fromJson(json);
}

/// @nodoc
mixin _$Accesses {
  List<dynamic> get accessesList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AccessesCopyWith<Accesses> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccessesCopyWith<$Res> {
  factory $AccessesCopyWith(Accesses value, $Res Function(Accesses) then) =
      _$AccessesCopyWithImpl<$Res, Accesses>;
  @useResult
  $Res call({List<dynamic> accessesList});
}

/// @nodoc
class _$AccessesCopyWithImpl<$Res, $Val extends Accesses>
    implements $AccessesCopyWith<$Res> {
  _$AccessesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessesList = null,
  }) {
    return _then(_value.copyWith(
      accessesList: null == accessesList
          ? _value.accessesList
          : accessesList // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AccessesCopyWith<$Res> implements $AccessesCopyWith<$Res> {
  factory _$$_AccessesCopyWith(
          _$_Accesses value, $Res Function(_$_Accesses) then) =
      __$$_AccessesCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<dynamic> accessesList});
}

/// @nodoc
class __$$_AccessesCopyWithImpl<$Res>
    extends _$AccessesCopyWithImpl<$Res, _$_Accesses>
    implements _$$_AccessesCopyWith<$Res> {
  __$$_AccessesCopyWithImpl(
      _$_Accesses _value, $Res Function(_$_Accesses) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessesList = null,
  }) {
    return _then(_$_Accesses(
      accessesList: null == accessesList
          ? _value._accessesList
          : accessesList // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Accesses extends _Accesses {
  const _$_Accesses({required final List<dynamic> accessesList})
      : _accessesList = accessesList,
        super._();

  factory _$_Accesses.fromJson(Map<String, dynamic> json) =>
      _$$_AccessesFromJson(json);

  final List<dynamic> _accessesList;
  @override
  List<dynamic> get accessesList {
    if (_accessesList is EqualUnmodifiableListView) return _accessesList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_accessesList);
  }

  @override
  String toString() {
    return 'Accesses(accessesList: $accessesList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Accesses &&
            const DeepCollectionEquality()
                .equals(other._accessesList, _accessesList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_accessesList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AccessesCopyWith<_$_Accesses> get copyWith =>
      __$$_AccessesCopyWithImpl<_$_Accesses>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AccessesToJson(
      this,
    );
  }
}

abstract class _Accesses extends Accesses {
  const factory _Accesses({required final List<dynamic> accessesList}) =
      _$_Accesses;
  const _Accesses._() : super._();

  factory _Accesses.fromJson(Map<String, dynamic> json) = _$_Accesses.fromJson;

  @override
  List<dynamic> get accessesList;
  @override
  @JsonKey(ignore: true)
  _$$_AccessesCopyWith<_$_Accesses> get copyWith =>
      throw _privateConstructorUsedError;
}
