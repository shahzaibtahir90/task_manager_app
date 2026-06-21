import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> signup({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (displayName != null && displayName.trim().isNotEmpty) {
        try {
          await userCredential.user?.updateDisplayName(displayName.trim());
          await userCredential.user?.reload();
        } catch (e) {
          debugPrint('Display name update skipped: $e');
        }
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw 'An unexpected error occurred during signup: $e';
    }
  }

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw 'An unexpected error occurred during login: $e';
    }
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Stream<User?> authStateChanges() {
    return _firebaseAuth.authStateChanges();
  }

  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'An account already exists for that email.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
      case 'invalid-credential':
        return 'The email or password is incorrect.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'operation-not-allowed':
      case 'admin-restricted-operation':
        return 'Email/password sign-in is disabled in Firebase. Enable it under Authentication > Sign-in method.';
      case 'network-request-failed':
        return 'Network error. Check your internet connection and try again.';
      case 'too-many-requests':
        return 'Too many attempts. Please wait a few minutes and try again.';
      case 'internal-error':
      case 'unknown':
        return _firebaseSetupHint(e);
      default:
        final message = e.message?.trim();
        if (message == null || message.isEmpty || message == 'Error') {
          return _firebaseSetupHint(e);
        }
        return '${e.code}: $message';
    }
  }

  String _firebaseSetupHint(FirebaseAuthException e) {
    return 'Firebase authentication failed (${e.code}). '
        'In Firebase Console: enable Email/Password under Authentication, '
        'add your Android SHA-1 fingerprint under Project settings, '
        'then rebuild the app.';
  }
}
