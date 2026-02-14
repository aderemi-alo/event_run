// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$InventoryState {
  List<InventoryItemEntity> get inventoryItems =>
      throw _privateConstructorUsedError;
  List<String> get categories => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  ActionState get actionState => throw _privateConstructorUsedError;
  String? get actionError => throw _privateConstructorUsedError;

  /// Create a copy of InventoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InventoryStateCopyWith<InventoryState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryStateCopyWith<$Res> {
  factory $InventoryStateCopyWith(
    InventoryState value,
    $Res Function(InventoryState) then,
  ) = _$InventoryStateCopyWithImpl<$Res, InventoryState>;
  @useResult
  $Res call({
    List<InventoryItemEntity> inventoryItems,
    List<String> categories,
    bool isLoading,
    String? error,
    ActionState actionState,
    String? actionError,
  });
}

/// @nodoc
class _$InventoryStateCopyWithImpl<$Res, $Val extends InventoryState>
    implements $InventoryStateCopyWith<$Res> {
  _$InventoryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InventoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inventoryItems = null,
    Object? categories = null,
    Object? isLoading = null,
    Object? error = freezed,
    Object? actionState = null,
    Object? actionError = freezed,
  }) {
    return _then(
      _value.copyWith(
            inventoryItems: null == inventoryItems
                ? _value.inventoryItems
                : inventoryItems // ignore: cast_nullable_to_non_nullable
                      as List<InventoryItemEntity>,
            categories: null == categories
                ? _value.categories
                : categories // ignore: cast_nullable_to_non_nullable
                      as List<String>,
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
abstract class _$$InventoryStateImplCopyWith<$Res>
    implements $InventoryStateCopyWith<$Res> {
  factory _$$InventoryStateImplCopyWith(
    _$InventoryStateImpl value,
    $Res Function(_$InventoryStateImpl) then,
  ) = __$$InventoryStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<InventoryItemEntity> inventoryItems,
    List<String> categories,
    bool isLoading,
    String? error,
    ActionState actionState,
    String? actionError,
  });
}

/// @nodoc
class __$$InventoryStateImplCopyWithImpl<$Res>
    extends _$InventoryStateCopyWithImpl<$Res, _$InventoryStateImpl>
    implements _$$InventoryStateImplCopyWith<$Res> {
  __$$InventoryStateImplCopyWithImpl(
    _$InventoryStateImpl _value,
    $Res Function(_$InventoryStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InventoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inventoryItems = null,
    Object? categories = null,
    Object? isLoading = null,
    Object? error = freezed,
    Object? actionState = null,
    Object? actionError = freezed,
  }) {
    return _then(
      _$InventoryStateImpl(
        inventoryItems: null == inventoryItems
            ? _value._inventoryItems
            : inventoryItems // ignore: cast_nullable_to_non_nullable
                  as List<InventoryItemEntity>,
        categories: null == categories
            ? _value._categories
            : categories // ignore: cast_nullable_to_non_nullable
                  as List<String>,
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

class _$InventoryStateImpl implements _InventoryState {
  const _$InventoryStateImpl({
    final List<InventoryItemEntity> inventoryItems = const [],
    final List<String> categories = const [],
    this.isLoading = false,
    this.error = null,
    this.actionState = ActionState.idle,
    this.actionError = null,
  }) : _inventoryItems = inventoryItems,
       _categories = categories;

  final List<InventoryItemEntity> _inventoryItems;
  @override
  @JsonKey()
  List<InventoryItemEntity> get inventoryItems {
    if (_inventoryItems is EqualUnmodifiableListView) return _inventoryItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_inventoryItems);
  }

  final List<String> _categories;
  @override
  @JsonKey()
  List<String> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

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
    return 'InventoryState(inventoryItems: $inventoryItems, categories: $categories, isLoading: $isLoading, error: $error, actionState: $actionState, actionError: $actionError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryStateImpl &&
            const DeepCollectionEquality().equals(
              other._inventoryItems,
              _inventoryItems,
            ) &&
            const DeepCollectionEquality().equals(
              other._categories,
              _categories,
            ) &&
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
    const DeepCollectionEquality().hash(_inventoryItems),
    const DeepCollectionEquality().hash(_categories),
    isLoading,
    error,
    actionState,
    actionError,
  );

  /// Create a copy of InventoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryStateImplCopyWith<_$InventoryStateImpl> get copyWith =>
      __$$InventoryStateImplCopyWithImpl<_$InventoryStateImpl>(
        this,
        _$identity,
      );
}

abstract class _InventoryState implements InventoryState {
  const factory _InventoryState({
    final List<InventoryItemEntity> inventoryItems,
    final List<String> categories,
    final bool isLoading,
    final String? error,
    final ActionState actionState,
    final String? actionError,
  }) = _$InventoryStateImpl;

  @override
  List<InventoryItemEntity> get inventoryItems;
  @override
  List<String> get categories;
  @override
  bool get isLoading;
  @override
  String? get error;
  @override
  ActionState get actionState;
  @override
  String? get actionError;

  /// Create a copy of InventoryState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InventoryStateImplCopyWith<_$InventoryStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
