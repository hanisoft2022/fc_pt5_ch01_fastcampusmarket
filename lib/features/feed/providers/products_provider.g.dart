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
String _$watchProductsHash() => r'2c51b0f89996a8cb196607e8e95dbcbc2cf544e8';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [watchProducts].
@ProviderFor(watchProducts)
const watchProductsProvider = WatchProductsFamily();

/// See also [watchProducts].
class WatchProductsFamily extends Family<AsyncValue<QuerySnapshot<Product>>> {
  /// See also [watchProducts].
  const WatchProductsFamily();

  /// See also [watchProducts].
  WatchProductsProvider call(String? query) {
    return WatchProductsProvider(query);
  }

  @override
  WatchProductsProvider getProviderOverride(
    covariant WatchProductsProvider provider,
  ) {
    return call(provider.query);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'watchProductsProvider';
}

/// See also [watchProducts].
class WatchProductsProvider
    extends AutoDisposeStreamProvider<QuerySnapshot<Product>> {
  /// See also [watchProducts].
  WatchProductsProvider(String? query)
    : this._internal(
        (ref) => watchProducts(ref as WatchProductsRef, query),
        from: watchProductsProvider,
        name: r'watchProductsProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$watchProductsHash,
        dependencies: WatchProductsFamily._dependencies,
        allTransitiveDependencies:
            WatchProductsFamily._allTransitiveDependencies,
        query: query,
      );

  WatchProductsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final String? query;

  @override
  Override overrideWith(
    Stream<QuerySnapshot<Product>> Function(WatchProductsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WatchProductsProvider._internal(
        (ref) => create(ref as WatchProductsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<QuerySnapshot<Product>> createElement() {
    return _WatchProductsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WatchProductsProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin WatchProductsRef on AutoDisposeStreamProviderRef<QuerySnapshot<Product>> {
  /// The parameter `query` of this provider.
  String? get query;
}

class _WatchProductsProviderElement
    extends AutoDisposeStreamProviderElement<QuerySnapshot<Product>>
    with WatchProductsRef {
  _WatchProductsProviderElement(super.provider);

  @override
  String? get query => (origin as WatchProductsProvider).query;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
