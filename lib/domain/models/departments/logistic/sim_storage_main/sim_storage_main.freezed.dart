// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sim_storage_main.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SimStorageMain _$SimStorageMainFromJson(Map<String, dynamic> json) {
  return _SimStorageMain.fromJson(json);
}

/// @nodoc
mixin _$SimStorageMain {
  Map<String, dynamic> get elements => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SimStorageMainCopyWith<SimStorageMain> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SimStorageMainCopyWith<$Res> {
  factory $SimStorageMainCopyWith(
          SimStorageMain value, $Res Function(SimStorageMain) then) =
      _$SimStorageMainCopyWithImpl<$Res, SimStorageMain>;
  @useResult
  $Res call({Map<String, dynamic> elements});
}

/// @nodoc
class _$SimStorageMainCopyWithImpl<$Res, $Val extends SimStorageMain>
    implements $SimStorageMainCopyWith<$Res> {
  _$SimStorageMainCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? elements = null,
  }) {
    return _then(_value.copyWith(
      elements: null == elements
          ? _value.elements
          : elements // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SimStorageMainCopyWith<$Res>
    implements $SimStorageMainCopyWith<$Res> {
  factory _$$_SimStorageMainCopyWith(
          _$_SimStorageMain value, $Res Function(_$_SimStorageMain) then) =
      __$$_SimStorageMainCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, dynamic> elements});
}

/// @nodoc
class __$$_SimStorageMainCopyWithImpl<$Res>
    extends _$SimStorageMainCopyWithImpl<$Res, _$_SimStorageMain>
    implements _$$_SimStorageMainCopyWith<$Res> {
  __$$_SimStorageMainCopyWithImpl(
      _$_SimStorageMain _value, $Res Function(_$_SimStorageMain) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? elements = null,
  }) {
    return _then(_$_SimStorageMain(
      elements: null == elements
          ? _value._elements
          : elements // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SimStorageMain extends _SimStorageMain {
  const _$_SimStorageMain({required final Map<String, dynamic> elements})
      : _elements = elements,
        super._();

  factory _$_SimStorageMain.fromJson(Map<String, dynamic> json) =>
      _$$_SimStorageMainFromJson(json);

  final Map<String, dynamic> _elements;
  @override
  Map<String, dynamic> get elements {
    if (_elements is EqualUnmodifiableMapView) return _elements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_elements);
  }

  @override
  String toString() {
    return 'SimStorageMain(elements: $elements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SimStorageMain &&
            const DeepCollectionEquality().equals(other._elements, _elements));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_elements));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SimStorageMainCopyWith<_$_SimStorageMain> get copyWith =>
      __$$_SimStorageMainCopyWithImpl<_$_SimStorageMain>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SimStorageMainToJson(
      this,
    );
  }
}

abstract class _SimStorageMain extends SimStorageMain {
  const factory _SimStorageMain(
      {required final Map<String, dynamic> elements}) = _$_SimStorageMain;
  const _SimStorageMain._() : super._();

  factory _SimStorageMain.fromJson(Map<String, dynamic> json) =
      _$_SimStorageMain.fromJson;

  @override
  Map<String, dynamic> get elements;
  @override
  @JsonKey(ignore: true)
  _$$_SimStorageMainCopyWith<_$_SimStorageMain> get copyWith =>
      throw _privateConstructorUsedError;
}
