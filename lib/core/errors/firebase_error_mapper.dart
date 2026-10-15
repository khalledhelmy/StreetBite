import 'package:firebase_auth/firebase_auth.dart';
import 'package:street_bite/core/errors/failures.dart';

Failure mapFirebaseAuthError(FirebaseAuthException e) {
  switch (e.code) {
    case 'email-already-in-use':
      return AuthFailure('auth_errors.email_in_use', code: e.code);
    case 'invalid-email':
      return AuthFailure('auth_errors.invalid_email', code: e.code);
    case 'weak-password':
      return AuthFailure('auth_errors.weak_password', code: e.code);
    case 'invalid-credential':
    case 'wrong-password':
    case 'user-not-found':
      return AuthFailure('auth_errors.invalid_credentials', code: e.code);
    case 'user-disabled':
      return AuthFailure('auth_errors.user_disabled', code: e.code);
    case 'too-many-requests':
      return AuthFailure('auth_errors.too_many_requests', code: e.code);
    case 'network-request-failed':
      return const NetworkFailure();
    case 'operation-not-allowed':
      return AuthFailure('auth_errors.operation_not_allowed', code: e.code);
    case 'requires-recent-login':
      return AuthFailure('auth_errors.requires_recent_login', code: e.code);
    default:
      return AuthFailure('auth_errors.failed', code: e.code);
  }
}
