import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/widgets.dart';
import 'package:flutter_faces/auth/extensions/extensions.dart';
import 'package:flutter_faces/auth/models/models.dart';
import 'package:flutter_faces/cache/cache_client.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

class SignUpWithEmailAndPasswordFailure implements Exception {
  final String message;

  const SignUpWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred',
  ]);

  factory SignUpWithEmailAndPasswordFailure.fromCode(
    BuildContext context,
    String code,
  ) {
    switch (code) {
      case 'invalid-email':
        return SignUpWithEmailAndPasswordFailure(
          AppLocalizations.of(context)!.signUpInvalidEmail,
        );

      case 'user-disabled':
        return SignUpWithEmailAndPasswordFailure(
          AppLocalizations.of(context)!.signUpUserDisabled,
        );

      case 'email-already-in-use':
        return SignUpWithEmailAndPasswordFailure(
          AppLocalizations.of(context)!.signUpEmailInUse,
        );

      case 'operation-not-allowed':
        return SignUpWithEmailAndPasswordFailure(
          AppLocalizations.of(context)!.operationNotAllowed,
        );

      case 'weak-password':
        return SignUpWithEmailAndPasswordFailure(
          AppLocalizations.of(context)!.weakPassword,
        );

      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }
}

class LogInWithEmailAndPasswordFailure implements Exception {
  final String message;

  const LogInWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred',
  ]);

  factory LogInWithEmailAndPasswordFailure.fromCode(
    BuildContext context,
    String code,
  ) {
    switch (code) {
      case 'invalid-email':
        return LogInWithEmailAndPasswordFailure(
          AppLocalizations.of(context)!.loginInvalidEmail,
        );

      case 'user-disabled':
        return LogInWithEmailAndPasswordFailure(
          AppLocalizations.of(context)!.loginUserDisabled,
        );

      case 'user-not-found':
        return LogInWithEmailAndPasswordFailure(
          AppLocalizations.of(context)!.loginUserNotFound,
        );

      case 'wrong-password':
        return LogInWithEmailAndPasswordFailure(
          AppLocalizations.of(context)!.loginWrongPassword,
        );

      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }
}

class LogInWithGoogleFailure implements Exception {
  final String message;

  const LogInWithGoogleFailure([
    this.message = 'An unknown exception occurred',
  ]);

  factory LogInWithGoogleFailure.fromCode(
    BuildContext context,
    String code,
  ) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return LogInWithGoogleFailure(
          AppLocalizations.of(context)!.loginGoogleDifferentCreds,
        );

      case 'invalid-credential':
        return LogInWithGoogleFailure(
          AppLocalizations.of(context)!.loginGoogleInvalidCreds,
        );

      case 'operation-not-allowed':
        return LogInWithGoogleFailure(
          AppLocalizations.of(context)!.loginGoogleOperationNotAllowed,
        );

      case 'user-disabled':
        return LogInWithGoogleFailure(
          AppLocalizations.of(context)!.loginGoogleUserDisabled,
        );

      case 'user-not-found':
        return LogInWithGoogleFailure(
          AppLocalizations.of(context)!.loginGoogleUserNotFound,
        );

      case 'wrong-password':
        return LogInWithGoogleFailure(
          AppLocalizations.of(context)!.loginGoogleWrongPassword,
        );

      case 'invalid-verification-code':
        return LogInWithGoogleFailure(
          AppLocalizations.of(context)!.loginGoogleInvalidVerificationCode,
        );

      case 'invalid-verification-id':
        return LogInWithGoogleFailure(
          AppLocalizations.of(context)!.loginGoogleInvalidVerificationId,
        );

      default:
        return const LogInWithGoogleFailure();
    }
  }
}

class LogOutFailure implements Exception {}

class AuthenticationRepository {
  final CacheClient _cache;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  @visibleForTesting
  bool isWeb = kIsWeb;

  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  AuthenticationRepository({
    CacheClient? cache,
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _cache = cache ?? CacheClient(),
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  Stream<User> get user =>
      _firebaseAuth.authStateChanges().map((firebase_auth.User? firebaseUser) {
        final User user =
            firebaseUser == null ? User.empty : firebaseUser.toUser;

        _cache.write(key: userCacheKey, value: user);
        return user;
      });

  User get currentUser => _cache.read<User>(key: userCacheKey) ?? User.empty;

  Future<void> signUp({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(context, e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  Future<void> logInWithGoogle(
    BuildContext context,
  ) async {
    try {
      late final firebase_auth.AuthCredential credential;

      if (isWeb) {
        final firebase_auth.GoogleAuthProvider googleProvider =
            firebase_auth.GoogleAuthProvider();

        final firebase_auth.UserCredential userCredential =
            await _firebaseAuth.signInWithPopup(
          googleProvider,
        );

        credential = userCredential.credential!;
      } else {
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        final GoogleSignInAuthentication googleAuth =
            await googleUser!.authentication;

        credential = firebase_auth.GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
      }

      await _firebaseAuth.signInWithCredential(credential);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithGoogleFailure.fromCode(context, e.code);
    } catch (_) {
      throw const LogInWithGoogleFailure();
    }
  }

  Future<void> logInWithEmailAndPassword({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(context, e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } on Exception {
      throw LogOutFailure();
    }
  }
}
