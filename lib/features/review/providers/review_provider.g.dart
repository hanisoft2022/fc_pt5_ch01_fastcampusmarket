// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$reviewFirestoreDatasourceHash() =>
    r'e5097cae4892d243ff2c7ef01758b3dc4ad33b55';

/// See also [reviewFirestoreDatasource].
@ProviderFor(reviewFirestoreDatasource)
final reviewFirestoreDatasourceProvider =
    AutoDisposeProvider<ReviewFirestoreDatasource>.internal(
      reviewFirestoreDatasource,
      name: r'reviewFirestoreDatasourceProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$reviewFirestoreDatasourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ReviewFirestoreDatasourceRef =
    AutoDisposeProviderRef<ReviewFirestoreDatasource>;
String _$watchReviewsHash() => r'bb5a2f9cd9bf32caa284e1119d48537eeaa3c732';

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

/// See also [watchReviews].
@ProviderFor(watchReviews)
const watchReviewsProvider = WatchReviewsFamily();

/// See also [watchReviews].
class WatchReviewsFamily extends Family<AsyncValue<List<Review>>> {
  /// See also [watchReviews].
  const WatchReviewsFamily();

  /// See also [watchReviews].
  WatchReviewsProvider call(String productId) {
    return WatchReviewsProvider(productId);
  }

  @override
  WatchReviewsProvider getProviderOverride(
    covariant WatchReviewsProvider provider,
  ) {
    return call(provider.productId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'watchReviewsProvider';
}

/// See also [watchReviews].
class WatchReviewsProvider extends AutoDisposeStreamProvider<List<Review>> {
  /// See also [watchReviews].
  WatchReviewsProvider(String productId)
    : this._internal(
        (ref) => watchReviews(ref as WatchReviewsRef, productId),
        from: watchReviewsProvider,
        name: r'watchReviewsProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$watchReviewsHash,
        dependencies: WatchReviewsFamily._dependencies,
        allTransitiveDependencies:
            WatchReviewsFamily._allTransitiveDependencies,
        productId: productId,
      );

  WatchReviewsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productId,
  }) : super.internal();

  final String productId;

  @override
  Override overrideWith(
    Stream<List<Review>> Function(WatchReviewsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WatchReviewsProvider._internal(
        (ref) => create(ref as WatchReviewsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productId: productId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Review>> createElement() {
    return _WatchReviewsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WatchReviewsProvider && other.productId == productId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin WatchReviewsRef on AutoDisposeStreamProviderRef<List<Review>> {
  /// The parameter `productId` of this provider.
  String get productId;
}

class _WatchReviewsProviderElement
    extends AutoDisposeStreamProviderElement<List<Review>>
    with WatchReviewsRef {
  _WatchReviewsProviderElement(super.provider);

  @override
  String get productId => (origin as WatchReviewsProvider).productId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
