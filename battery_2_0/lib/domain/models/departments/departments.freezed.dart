// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'departments.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Departments _$DepartmentsFromJson(Map<String, dynamic> json) {
  return _Departments.fromJson(json);
}

/// @nodoc
mixin _$Departments {
  Map<String, dynamic> get departments => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DepartmentsCopyWith<Departments> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DepartmentsCopyWith<$Res> {
  factory $DepartmentsCopyWith(
          Departments value, $Res Function(Departments) then) =
      _$DepartmentsCopyWithImpl<$Res, Departments>;
  @useResult
  $Res call({Map<String, dynamic> departments});
}

/// @nodoc
class _$DepartmentsCopyWithImpl<$Res, $Val extends Departments>
    implements $DepartmentsCopyWith<$Res> {
  _$DepartmentsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? departments = null,
  }) {
    return _then(_value.copyWith(
      departments: null == departments
          ? _value.departments
          : departments // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DepartmentsCopyWith<$Res>
    implements $DepartmentsCopyWith<$Res> {
  factory _$$_DepartmentsCopyWith(
          _$_Departments value, $Res Function(_$_Departments) then) =
      __$$_DepartmentsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, dynamic> departments});
}

/// @nodoc
class __$$_DepartmentsCopyWithImpl<$Res>
    extends _$DepartmentsCopyWithImpl<$Res, _$_Departments>
    implements _$$_DepartmentsCopyWith<$Res> {
  __$$_DepartmentsCopyWithImpl(
      _$_Departments _value, $Res Function(_$_Departments) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? departments = null,
  }) {
    return _then(_$_Departments(
      departments: null == departments
          ? _value._departments
          : departments // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Departments extends _Departments {
  const _$_Departments({required final Map<String, dynamic> departments})
      : _departments = departments,
        super._();

  factory _$_Departments.fromJson(Map<String, dynamic> json) =>
      _$$_DepartmentsFromJson(json);

  final Map<String, dynamic> _departments;
  @override
  Map<String, dynamic> get departments {
    if (_departments is EqualUnmodifiableMapView) return _departments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_departments);
  }

  @override
  String toString() {
    return 'Departments(departments: $departments)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Departments &&
            const DeepCollectionEquality()
                .equals(other._departments, _departments));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_departments));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DepartmentsCopyWith<_$_Departments> get copyWith =>
      __$$_DepartmentsCopyWithImpl<_$_Departments>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DepartmentsToJson(
      this,
    );
  }
}

abstract class _Departments extends Departments {
  const factory _Departments(
      {required final Map<String, dynamic> departments}) = _$_Departments;
  const _Departments._() : super._();

  factory _Departments.fromJson(Map<String, dynamic> json) =
      _$_Departments.fromJson;

  @override
  Map<String, dynamic> get departments;
  @override
  @JsonKey(ignore: true)
  _$$_DepartmentsCopyWith<_$_Departments> get copyWith =>
      throw _privateConstructorUsedError;
}
