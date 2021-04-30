// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'void_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$VoidResultTearOff {
  const _$VoidResultTearOff();

  VoidSuccess success() {
    return const VoidSuccess();
  }

  VoidFailure failure({required String reason}) {
    return VoidFailure(
      reason: reason,
    );
  }
}

/// @nodoc
const $VoidResult = _$VoidResultTearOff();

/// @nodoc
mixin _$VoidResult {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() success,
    required TResult Function(String reason) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? success,
    TResult Function(String reason)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VoidSuccess value) success,
    required TResult Function(VoidFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VoidSuccess value)? success,
    TResult Function(VoidFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoidResultCopyWith<$Res> {
  factory $VoidResultCopyWith(
          VoidResult value, $Res Function(VoidResult) then) =
      _$VoidResultCopyWithImpl<$Res>;
}

/// @nodoc
class _$VoidResultCopyWithImpl<$Res> implements $VoidResultCopyWith<$Res> {
  _$VoidResultCopyWithImpl(this._value, this._then);

  final VoidResult _value;
  // ignore: unused_field
  final $Res Function(VoidResult) _then;
}

/// @nodoc
abstract class $VoidSuccessCopyWith<$Res> {
  factory $VoidSuccessCopyWith(
          VoidSuccess value, $Res Function(VoidSuccess) then) =
      _$VoidSuccessCopyWithImpl<$Res>;
}

/// @nodoc
class _$VoidSuccessCopyWithImpl<$Res> extends _$VoidResultCopyWithImpl<$Res>
    implements $VoidSuccessCopyWith<$Res> {
  _$VoidSuccessCopyWithImpl(
      VoidSuccess _value, $Res Function(VoidSuccess) _then)
      : super(_value, (v) => _then(v as VoidSuccess));

  @override
  VoidSuccess get _value => super._value as VoidSuccess;
}

/// @nodoc

class _$VoidSuccess with DiagnosticableTreeMixin implements VoidSuccess {
  const _$VoidSuccess();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'VoidResult.success()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'VoidResult.success'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is VoidSuccess);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() success,
    required TResult Function(String reason) failure,
  }) {
    return success();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? success,
    TResult Function(String reason)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VoidSuccess value) success,
    required TResult Function(VoidFailure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VoidSuccess value)? success,
    TResult Function(VoidFailure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class VoidSuccess implements VoidResult {
  const factory VoidSuccess() = _$VoidSuccess;
}

/// @nodoc
abstract class $VoidFailureCopyWith<$Res> {
  factory $VoidFailureCopyWith(
          VoidFailure value, $Res Function(VoidFailure) then) =
      _$VoidFailureCopyWithImpl<$Res>;
  $Res call({String reason});
}

/// @nodoc
class _$VoidFailureCopyWithImpl<$Res> extends _$VoidResultCopyWithImpl<$Res>
    implements $VoidFailureCopyWith<$Res> {
  _$VoidFailureCopyWithImpl(
      VoidFailure _value, $Res Function(VoidFailure) _then)
      : super(_value, (v) => _then(v as VoidFailure));

  @override
  VoidFailure get _value => super._value as VoidFailure;

  @override
  $Res call({
    Object? reason = freezed,
  }) {
    return _then(VoidFailure(
      reason: reason == freezed
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$VoidFailure with DiagnosticableTreeMixin implements VoidFailure {
  const _$VoidFailure({required this.reason});

  @override
  final String reason;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'VoidResult.failure(reason: $reason)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'VoidResult.failure'))
      ..add(DiagnosticsProperty('reason', reason));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is VoidFailure &&
            (identical(other.reason, reason) ||
                const DeepCollectionEquality().equals(other.reason, reason)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(reason);

  @JsonKey(ignore: true)
  @override
  $VoidFailureCopyWith<VoidFailure> get copyWith =>
      _$VoidFailureCopyWithImpl<VoidFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() success,
    required TResult Function(String reason) failure,
  }) {
    return failure(reason);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? success,
    TResult Function(String reason)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(reason);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VoidSuccess value) success,
    required TResult Function(VoidFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VoidSuccess value)? success,
    TResult Function(VoidFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class VoidFailure implements VoidResult {
  const factory VoidFailure({required String reason}) = _$VoidFailure;

  String get reason => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VoidFailureCopyWith<VoidFailure> get copyWith =>
      throw _privateConstructorUsedError;
}
