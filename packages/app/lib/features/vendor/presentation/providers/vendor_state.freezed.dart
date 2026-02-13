// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vendor_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$VendorState {
  VendorEntity? get currentVendor => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  ActionState get actionState => throw _privateConstructorUsedError;
  String? get actionError => throw _privateConstructorUsedError;

  /// Create a copy of VendorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VendorStateCopyWith<VendorState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VendorStateCopyWith<$Res> {
  factory $VendorStateCopyWith(
    VendorState value,
    $Res Function(VendorState) then,
  ) = _$VendorStateCopyWithImpl<$Res, VendorState>;
  @useResult
  $Res call({
    VendorEntity? currentVendor,
    bool isLoading,
    String? error,
    ActionState actionState,
    String? actionError,
  });
}

/// @nodoc
class _$VendorStateCopyWithImpl<$Res, $Val extends VendorState>
    implements $VendorStateCopyWith<$Res> {
  _$VendorStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VendorState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentVendor = freezed,
    Object? isLoading = null,
    Object? error = freezed,
    Object? actionState = null,
    Object? actionError = freezed,
  }) {
    return _then(
      _value.copyWith(
            currentVendor: freezed == currentVendor
                ? _value.currentVendor
                : currentVendor // ignore: cast_nullable_to_non_nullable
                      as VendorEntity?,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
            actionState: null == actionState
                ? _value.actionState
                : actionState // ignore: cast_nullable_to_non_nullable
                      as ActionState,
            actionError: freezed == actionError
                ? _value.actionError
                : actionError // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VendorStateImplCopyWith<$Res>
    implements $VendorStateCopyWith<$Res> {
  factory _$$VendorStateImplCopyWith(
    _$VendorStateImpl value,
    $Res Function(_$VendorStateImpl) then,
  ) = __$$VendorStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    VendorEntity? currentVendor,
    bool isLoading,
    String? error,
    ActionState actionState,
    String? actionError,
  });
}

/// @nodoc
class __$$VendorStateImplCopyWithImpl<$Res>
    extends _$VendorStateCopyWithImpl<$Res, _$VendorStateImpl>
    implements _$$VendorStateImplCopyWith<$Res> {
  __$$VendorStateImplCopyWithImpl(
    _$VendorStateImpl _value,
    $Res Function(_$VendorStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of VendorState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentVendor = freezed,
    Object? isLoading = null,
    Object? error = freezed,
    Object? actionState = null,
    Object? actionError = freezed,
  }) {
    return _then(
      _$VendorStateImpl(
        currentVendor: freezed == currentVendor
            ? _value.currentVendor
            : currentVendor // ignore: cast_nullable_to_non_nullable
                  as VendorEntity?,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
        actionState: null == actionState
            ? _value.actionState
            : actionState // ignore: cast_nullable_to_non_nullable
                  as ActionState,
        actionError: freezed == actionError
            ? _value.actionError
            : actionError // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$VendorStateImpl implements _VendorState {
  const _$VendorStateImpl({
    this.currentVendor = null,
    this.isLoading = false,
    this.error = null,
    this.actionState = ActionState.idle,
    this.actionError = null,
  });

  @override
  @JsonKey()
  final VendorEntity? currentVendor;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final String? error;
  @override
  @JsonKey()
  final ActionState actionState;
  @override
  @JsonKey()
  final String? actionError;

  @override
  String toString() {
    return 'VendorState(currentVendor: $currentVendor, isLoading: $isLoading, error: $error, actionState: $actionState, actionError: $actionError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VendorStateImpl &&
            (identical(other.currentVendor, currentVendor) ||
                other.currentVendor == currentVendor) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.actionState, actionState) ||
                other.actionState == actionState) &&
            (identical(other.actionError, actionError) ||
                other.actionError == actionError));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    currentVendor,
    isLoading,
    error,
    actionState,
    actionError,
  );

  /// Create a copy of VendorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VendorStateImplCopyWith<_$VendorStateImpl> get copyWith =>
      __$$VendorStateImplCopyWithImpl<_$VendorStateImpl>(this, _$identity);
}

abstract class _VendorState implements VendorState {
  const factory _VendorState({
    final VendorEntity? currentVendor,
    final bool isLoading,
    final String? error,
    final ActionState actionState,
    final String? actionError,
  }) = _$VendorStateImpl;

  @override
  VendorEntity? get currentVendor;
  @override
  bool get isLoading;
  @override
  String? get error;
  @override
  ActionState get actionState;
  @override
  String? get actionError;

  /// Create a copy of VendorState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VendorStateImplCopyWith<_$VendorStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
