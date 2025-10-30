import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/app_user.dart';
import '../providers/app_user_provider.dart';
import '../services/analytics_service.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';

part 'auth_controller.g.dart';

class AuthState {
  final bool isLoading;
  final String? errorMessage;

  AuthState({this.isLoading = false, this.errorMessage});

  AuthState copyWith({bool? isLoading, String? errorMessage}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  AuthState build() {
    return AuthState();
  }

  AuthService get _authService => ref.read(authServiceProvider);
  FirestoreService get _firestoreService => ref.read(firestoreServiceProvider);
  AnalyticsService get _analyticsService => ref.read(analyticsServiceProvider);

  void _setLoading(bool loading) {
    state = state.copyWith(isLoading: loading, errorMessage: null);
  }

  void _setError(String? message) {
    state = state.copyWith(errorMessage: message, isLoading: false);
  }


  Future<bool> signInWithEmail(String email, String password) async {
    _setLoading(true);
    try {
      await _authService.signInWithEmail(email, password);
      await _analyticsService.logLogin('email_password');
      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e, s) {
      _setError(e.message);
      FirebaseCrashlytics.instance.recordError(e, s, reason: 'Email Sign In Failed');
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    _setLoading(true);
    try {
      final cred = await _authService.signInWithGoogle();

      if (cred?.user != null && cred?.additionalUserInfo?.isNewUser == true) {
        AppUser newUser = AppUser(
          uid: cred!.user!.uid,
          email: cred.user!.email,
          displayName: cred.user!.displayName,
          photoUrl: cred.user!.photoURL,
        );
        await _firestoreService.setUserData(newUser);
      }

      await _analyticsService.logLogin('google');
      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e, s) {
      _setError(e.message);
      FirebaseCrashlytics.instance.recordError(e, s, reason: 'Google Sign In Failed');
      return false;
    }
  }

  Future<bool> registerWithEmail(String email, String password) async {
    _setLoading(true);
    try {
      final cred = await _authService.registerWithEmail(email, password);
      if (cred?.user != null) {
        AppUser newUser = AppUser(uid: cred!.user!.uid, email: cred.user!.email);
        await _firestoreService.setUserData(newUser);
        await _analyticsService.logSignUp('email_password');
      }
      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e, s) {
      _setError(e.message);
      FirebaseCrashlytics.instance.recordError(e, s, reason: 'Registration Failed');
      return false;
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }
}
