// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'void_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VoidResult implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
    ..add(DiagnosticsProperty('type', 'VoidResult'))
    ;
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is VoidResult);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
    return 'VoidResult()';
}


}

/// @nodoc
class $VoidResultCopyWith<$Res>  {
$VoidResultCopyWith(VoidResult _, $Res Function(VoidResult) __);
}


/// Adds pattern-matching-related methods to [VoidResult].
extension VoidResultPatterns on VoidResult {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( VoidSuccess value)?  success,TResult Function( VoidFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case VoidSuccess() when success != null:
return success(_that);case VoidFailure() when failure != null:
return failure(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( VoidSuccess value)  success,required TResult Function( VoidFailure value)  failure,}){
final _that = this;
switch (_that) {
case VoidSuccess():
return success(_that);case VoidFailure():
return failure(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( VoidSuccess value)?  success,TResult? Function( VoidFailure value)?  failure,}){
final _that = this;
switch (_that) {
case VoidSuccess() when success != null:
return success(_that);case VoidFailure() when failure != null:
return failure(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  success,TResult Function( String reason)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case VoidSuccess() when success != null:
return success();case VoidFailure() when failure != null:
return failure(_that.reason);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  success,required TResult Function( String reason)  failure,}) {final _that = this;
switch (_that) {
case VoidSuccess():
return success();case VoidFailure():
return failure(_that.reason);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  success,TResult? Function( String reason)?  failure,}) {final _that = this;
switch (_that) {
case VoidSuccess() when success != null:
return success();case VoidFailure() when failure != null:
return failure(_that.reason);case _:
  return null;

}
}

}

/// @nodoc


class VoidSuccess with DiagnosticableTreeMixin implements VoidResult {
  const VoidSuccess();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
    ..add(DiagnosticsProperty('type', 'VoidResult.success'))
    ;
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is VoidSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
    return 'VoidResult.success()';
}


}




/// @nodoc


class VoidFailure with DiagnosticableTreeMixin implements VoidResult {
  const VoidFailure({required this.reason});
  

 final  String reason;

/// Create a copy of VoidResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoidFailureCopyWith<VoidFailure> get copyWith => _$VoidFailureCopyWithImpl<VoidFailure>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
    ..add(DiagnosticsProperty('type', 'VoidResult.failure'))
    ..add(DiagnosticsProperty('reason', reason));
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is VoidFailure&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode {
    return Object.hash(runtimeType,reason);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
    return 'VoidResult.failure(reason: $reason)';
}


}

/// @nodoc
abstract mixin class $VoidFailureCopyWith<$Res> implements $VoidResultCopyWith<$Res> {
  factory $VoidFailureCopyWith(VoidFailure value, $Res Function(VoidFailure) _then) = _$VoidFailureCopyWithImpl;
@useResult
$Res call({
 String reason
});




}
/// @nodoc
class _$VoidFailureCopyWithImpl<$Res>
    implements $VoidFailureCopyWith<$Res> {
  _$VoidFailureCopyWithImpl(this._self, this._then);

  final VoidFailure _self;
  final $Res Function(VoidFailure) _then;

/// Create a copy of VoidResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = null,}) {
  return _then(VoidFailure(
reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
