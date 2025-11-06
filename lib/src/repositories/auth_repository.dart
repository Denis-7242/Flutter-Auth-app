import 'package:firebase_auth/firebase_auth.dart';

/// Repository class that handles all authentication operations
class AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  /// Get the current user
  User? get currentUser => _firebaseAuth.currentUser;

  /// Stream of auth state changes
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  /// Sign in with email and password
  Future<AuthResult> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return AuthResult.success(user: userCredential.user);
    } on FirebaseAuthException catch (e) {
      return AuthResult.failure(error: _handleAuthException(e));
    } catch (e) {
      return AuthResult.failure(
        error: 'An unexpected error occurred. Please try again.',
      );
    }
  }

  /// Create a new user with email and password
  Future<AuthResult> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      
      // Send email verification
      await userCredential.user?.sendEmailVerification();
      
      return AuthResult.success(user: userCredential.user);
    } on FirebaseAuthException catch (e) {
      return AuthResult.failure(error: _handleAuthException(e));
    } catch (e) {
      return AuthResult.failure(
        error: 'An unexpected error occurred. Please try again.',
      );
    }
  }

  /// Sign out the current user
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  /// Send password reset email
  Future<AuthResult> sendPasswordResetEmail({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email.trim());
      return AuthResult.success();
    } on FirebaseAuthException catch (e) {
      return AuthResult.failure(error: _handleAuthException(e));
    } catch (e) {
      return AuthResult.failure(
        error: 'An unexpected error occurred. Please try again.',
      );
    }
  }

  /// Send email verification to current user
  Future<void> sendEmailVerification() async {
    await currentUser?.sendEmailVerification();
  }

  /// Reload current user data
  Future<void> reloadUser() async {
    await currentUser?.reload();
  }

  /// Handle Firebase Auth exceptions and return user-friendly messages
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No account found with this email. Please sign up.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'user-disabled':
        return 'This account has been disabled. Contact support.';
      case 'email-already-in-use':
        return 'An account already exists with this email.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled. Contact support.';
      case 'weak-password':
        return 'Please choose a stronger password.';
      case 'invalid-credential':
        return 'Invalid credentials. Please check your email and password.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'network-request-failed':
        return 'Network error. Please check your connection.';
      default:
        return 'Authentication failed. Please try again.';
    }
  }
}

/// Result class for authentication operations
class AuthResult {
  final bool isSuccess;
  final User? user;
  final String? error;

  AuthResult._({
    required this.isSuccess,
    this.user,
    this.error,
  });

  factory AuthResult.success({User? user}) {
    return AuthResult._(
      isSuccess: true,
      user: user,
    );
  }

  factory AuthResult.failure({required String error}) {
    return AuthResult._(
      isSuccess: false,
      error: error,
    );
  }
}