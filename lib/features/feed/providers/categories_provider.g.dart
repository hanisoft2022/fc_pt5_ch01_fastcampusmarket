// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$watchCategoriesHash() => r'158ddf9babb203863aac14c6cbb36f6fcc467a78';

/// See also [watchCategories].
@ProviderFor(watchCategories)
final watchCategoriesProvider =
    AutoDisposeStreamProvider<List<Category>>.internal(
      watchCategories,
      name: r'watchCategoriesProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$watchCategoriesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WatchCategoriesRef = AutoDisposeStreamProviderRef<List<Category>>;
String _$fetchCategoriesHash() => r'28c2142f2f35f4ff1ab839bea8713380f4057e62';

/// See also [fetchCategories].
@ProviderFor(fetchCategories)
final fetchCategoriesProvider =
    AutoDisposeFutureProvider<List<Category>>.internal(
      fetchCategories,
      name: r'fetchCategoriesProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$fetchCategoriesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FetchCategoriesRef = AutoDisposeFutureProviderRef<List<Category>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
