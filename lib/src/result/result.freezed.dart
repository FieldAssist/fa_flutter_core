// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ResultTearOff {
  const _$ResultTearOff();

  ResultSuccess<T> success<T>({required T data}) {
    return ResultSuccess<T>(
      data: data,
    );
  }

  ResultFailure<T> failure<T>({required String reason}) {
    return ResultFailure<T>(
      reason: reason,
    );
  }
}

/// @nodoc
const $Result = _$ResultTearOff();

/// @nodoc
mixin _$Result<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(String reason) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(String reason)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ResultSuccess<T> value) success,
    required TResult Function(ResultFailure<T> value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ResultSuccess<T> value)? success,
    TResult Function(ResultFailure<T> value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResultCopyWith<T, $Res> {
  factory $ResultCopyWith(Result<T> value, $Res Function(Result<T>) then) =
      _$ResultCopyWithImpl<T, $Res>;
}

/// @nodoc
class _$ResultCopyWithImpl<T, $Res> implements $ResultCopyWith<T, $Res> {
  _$ResultCopyWithImpl(this._value, this._then);

  final Result<T> _value;
  // ignore: unused_field
  final $Res Function(Result<T>) _then;
}

/// @nodoc
abstract class $ResultSuccessCopyWith<T, $Res> {
  factory $ResultSuccessCopyWith(
          ResultSuccess<T> value, $Res Function(ResultSuccess<T>) then) =
      _$ResultSuccessCopyWithImpl<T, $Res>;
  $Res call({T data});
}

/// @nodoc
class _$ResultSuccessCopyWithImpl<T, $Res> extends _$ResultCopyWithImpl<T, $Res>
    implements $ResultSuccessCopyWith<T, $Res> {
  _$ResultSuccessCopyWithImpl(
      ResultSuccess<T> _value, $Res Function(ResultSuccess<T>) _then)
      : super(_value, (v) => _then(v as ResultSuccess<T>));

  @override
  ResultSuccess<T> get _value => super._value as ResultSuccess<T>;

  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(ResultSuccess<T>(
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$ResultSuccess<T>
    with DiagnosticableTreeMixin
    implements ResultSuccess<T> {
  const _$ResultSuccess({required this.data});

  @override
  final T data;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Result<$T>.success(data: $data)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Result<$T>.success'))
      ..add(DiagnosticsProperty('data', data));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ResultSuccess<T> &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(data);

  @JsonKey(ignore: true)
  @override
  $ResultSuccessCopyWith<T, ResultSuccess<T>> get copyWith =>
      _$ResultSuccessCopyWithImpl<T, ResultSuccess<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(String reason) failure,
  }) {
    return success(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(String reason)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ResultSuccess<T> value) success,
    required TResult Function(ResultFailure<T> value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ResultSuccess<T> value)? success,
    TResult Function(ResultFailure<T> value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class ResultSuccess<T> implements Result<T> {
  const factory ResultSuccess({required T data}) = _$ResultSuccess<T>;

  T get data => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ResultSuccessCopyWith<T, ResultSuccess<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResultFailureCopyWith<T, $Res> {
  factory $ResultFailureCopyWith(
          ResultFailure<T> value, $Res Function(ResultFailure<T>) then) =
      _$ResultFailureCopyWithImpl<T, $Res>;
  $Res call({String reason});
}

/// @nodoc
class _$ResultFailureCopyWithImpl<T, $Res> extends _$ResultCopyWithImpl<T, $Res>
    implements $ResultFailureCopyWith<T, $Res> {
  _$ResultFailureCopyWithImpl(
      ResultFailure<T> _value, $Res Function(ResultFailure<T>) _then)
      : super(_value, (v) => _then(v as ResultFailure<T>));

  @override
  ResultFailure<T> get _value => super._value as ResultFailure<T>;

  @override
  $Res call({
    Object? reason = freezed,
  }) {
    return _then(ResultFailure<T>(
      reason: reason == freezed
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ResultFailure<T>
    with DiagnosticableTreeMixin
    implements ResultFailure<T> {
  const _$ResultFailure({required this.reason});

  @override
  final String reason;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Result<$T>.failure(reason: $reason)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Result<$T>.failure'))
      ..add(DiagnosticsProperty('reason', reason));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ResultFailure<T> &&
            (identical(other.reason, reason) ||
                const DeepCollectionEquality().equals(other.reason, reason)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(reason);

  @JsonKey(ignore: true)
  @override
  $ResultFailureCopyWith<T, ResultFailure<T>> get copyWith =>
      _$ResultFailureCopyWithImpl<T, ResultFailure<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(String reason) failure,
  }) {
    return failure(reason);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
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
    required TResult Function(ResultSuccess<T> value) success,
    required TResult Function(ResultFailure<T> value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ResultSuccess<T> value)? success,
    TResult Function(ResultFailure<T> value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class ResultFailure<T> implements Result<T> {
  const factory ResultFailure({required String reason}) = _$ResultFailure<T>;

  String get reason => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ResultFailureCopyWith<T, ResultFailure<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
