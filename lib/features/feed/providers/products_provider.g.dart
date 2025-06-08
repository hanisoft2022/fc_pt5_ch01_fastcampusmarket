// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchSaleProductsHash() => r'69e55d7bde141611eaedaf85fa569caf545e2244';

/// See also [fetchSaleProducts].
@ProviderFor(fetchSaleProducts)
final fetchSaleProductsProvider =
    AutoDisposeFutureProvider<List<Product>>.internal(
      fetchSaleProducts,
      name: r'fetchSaleProductsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$fetchSaleProductsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FetchSaleProductsRef = AutoDisposeFutureProviderRef<List<Product>>;
String _$watchSaleProductsHash() => r'c13fe178f9ae288430de547cec549f6658236111';

/// See also [watchSaleProducts].
@ProviderFor(watchSaleProducts)
final watchSaleProductsProvider =
    AutoDisposeStreamProvider<QuerySnapshot<Product>>.internal(
      watchSaleProducts,
      name: r'watchSaleProductsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$watchSaleProductsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WatchSaleProductsRef =
    AutoDisposeStreamProviderRef<QuerySnapshot<Product>>;
String _$fetchProductsHash() => r'8f6d09f59c2feecc24a2f9950e195242caf1cb48';

/// See also [fetchProducts].
@ProviderFor(fetchProducts)
final fetchProductsProvider = AutoDisposeFutureProvider<List<Product>>.internal(
  fetchProducts,
  name: r'fetchProductsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$fetchProductsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FetchProductsRef = AutoDisposeFutureProviderRef<List<Product>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
