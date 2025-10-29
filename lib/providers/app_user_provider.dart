import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/app_user.dart';
import '../services/analytics_service.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';

part 'app_user_provider.g.dart';

@Riverpod(keepAlive: true)
FirebaseAnalytics firebaseAnalytics(FirebaseAnalyticsRef ref) {
  return FirebaseAnalytics.instance;
}

@Riverpod(keepAlive: true)
FirebaseAnalyticsObserver firebaseAnalyticsObserver(FirebaseAnalyticsObserverRef ref) {
  return FirebaseAnalyticsObserver(analytics: ref.watch(firebaseAnalyticsProvider));
}

@Riverpod(keepAlive: true)
AnalyticsService analyticsService(AnalyticsServiceRef ref) {
  return AnalyticsService(ref.watch(firebaseAnalyticsProvider));
}

@Riverpod(keepAlive: true)
AuthService authService(AuthServiceRef ref) {
  return AuthService();
}

@Riverpod(keepAlive: true)
FirestoreService firestoreService(FirestoreServiceRef ref) {
  return FirestoreService();
}

@riverpod
Stream<User?> authStateChanges(AuthStateChangesRef ref) {
  return ref.watch(authServiceProvider).authStateChanges;
}

@riverpod
Stream<AppUser?> appUser(AppUserRef ref) {
  final authState = ref.watch(authStateChangesProvider);

  return authState.when(
    data: (user) {
      if (user != null) {
        final firestoreService = ref.watch(firestoreServiceProvider);
        return firestoreService.getUserDataStream(user.uid);
      }
      return Stream.value(null);
    },
    loading: () => Stream.value(null),
    error: (e, s) => Stream.error(e),
  );
}

@riverpod
Stream<QuerySnapshot> homeItemsStream(HomeItemsStreamRef ref) {
  return ref.watch(firestoreServiceProvider).getSomeHomeData();
}
