// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_items_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cartItemsHash() => r'511434284df408612991fcb29c0696cadbdd3468';

/// See also [cartItems].
@ProviderFor(cartItems)
final cartItemsProvider = AutoDisposeStreamProvider<List<CartItem>>.internal(
  cartItems,
  name: r'cartItemsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$cartItemsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CartItemsRef = AutoDisposeStreamProviderRef<List<CartItem>>;
String _$cartTotalHash() => r'f99d3bf932d1ebb03e11bf5f4c3a9882a3778fb8';

/// See also [cartTotal].
@ProviderFor(cartTotal)
final cartTotalProvider = AutoDisposeProvider<double>.internal(
  cartTotal,
  name: r'cartTotalProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$cartTotalHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CartTotalRef = AutoDisposeProviderRef<double>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
