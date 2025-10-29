// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$firebaseAnalyticsHash() => r'5a1ccf05c4f810fa886bb07980a8790e59b82b44';

/// See also [firebaseAnalytics].
@ProviderFor(firebaseAnalytics)
final firebaseAnalyticsProvider = Provider<FirebaseAnalytics>.internal(
  firebaseAnalytics,
  name: r'firebaseAnalyticsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$firebaseAnalyticsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FirebaseAnalyticsRef = ProviderRef<FirebaseAnalytics>;
String _$firebaseAnalyticsObserverHash() =>
    r'165570ddac97936b47de19754133b50485ee4440';

/// See also [firebaseAnalyticsObserver].
@ProviderFor(firebaseAnalyticsObserver)
final firebaseAnalyticsObserverProvider =
    Provider<FirebaseAnalyticsObserver>.internal(
  firebaseAnalyticsObserver,
  name: r'firebaseAnalyticsObserverProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$firebaseAnalyticsObserverHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FirebaseAnalyticsObserverRef = ProviderRef<FirebaseAnalyticsObserver>;
String _$analyticsServiceHash() => r'33ec3d9caa4b9598e898abf8ff9975aa7630bd92';

/// See also [analyticsService].
@ProviderFor(analyticsService)
final analyticsServiceProvider = Provider<AnalyticsService>.internal(
  analyticsService,
  name: r'analyticsServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$analyticsServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AnalyticsServiceRef = ProviderRef<AnalyticsService>;
String _$authServiceHash() => r'd95f6f0327b9783a3e7e039c4caaa93c6a60aa27';

/// See also [authService].
@ProviderFor(authService)
final authServiceProvider = Provider<AuthService>.internal(
  authService,
  name: r'authServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthServiceRef = ProviderRef<AuthService>;
String _$firestoreServiceHash() => r'd7a14e8468436c9c7998493c91fea3a6f785c799';

/// See also [firestoreService].
@ProviderFor(firestoreService)
final firestoreServiceProvider = Provider<FirestoreService>.internal(
  firestoreService,
  name: r'firestoreServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$firestoreServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FirestoreServiceRef = ProviderRef<FirestoreService>;
String _$authStateChangesHash() => r'fd97889ce8b804802afa0a6d5fba8af081fd7f36';

/// See also [authStateChanges].
@ProviderFor(authStateChanges)
final authStateChangesProvider = AutoDisposeStreamProvider<User?>.internal(
  authStateChanges,
  name: r'authStateChangesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authStateChangesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthStateChangesRef = AutoDisposeStreamProviderRef<User?>;
String _$appUserHash() => r'0af2d9d55d75d588e05000f0dd97c40b0278a4a9';

/// See also [appUser].
@ProviderFor(appUser)
final appUserProvider = AutoDisposeStreamProvider<AppUser?>.internal(
  appUser,
  name: r'appUserProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AppUserRef = AutoDisposeStreamProviderRef<AppUser?>;
String _$homeItemsStreamHash() => r'7801f9782b3b8f907163cc6fb6d3c3eceef162bb';

/// See also [homeItemsStream].
@ProviderFor(homeItemsStream)
final homeItemsStreamProvider =
    AutoDisposeStreamProvider<QuerySnapshot>.internal(
  homeItemsStream,
  name: r'homeItemsStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$homeItemsStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef HomeItemsStreamRef = AutoDisposeStreamProviderRef<QuerySnapshot>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
