class LogInWithLinkedinFailure implements Exception {
  const LogInWithLinkedinFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  factory LogInWithLinkedinFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const LogInWithLinkedinFailure(
          'Account exists with different credentials.',
        );
      case 'invalid-credential':
        return const LogInWithLinkedinFailure(
          'The credential received is malformed or has expired.',
        );
      case 'custom-token-mismatch':
        return const LogInWithLinkedinFailure(
          'The access token is mismatched',
        );
      case 'invalid-custom-token':
        return const LogInWithLinkedinFailure(
          'The Access token in invalid',
        );
      case 'operation-not-allowed':
        return const LogInWithLinkedinFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'user-disabled':
        return const LogInWithLinkedinFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithLinkedinFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithLinkedinFailure(
          'Incorrect password, please try again.',
        );
      case 'invalid-verification-code':
        return const LogInWithLinkedinFailure(
          'The credential verification code received is invalid.',
        );
      case 'invalid-verification-id':
        return const LogInWithLinkedinFailure(
          'The credential verification ID received is invalid.',
        );
      default:
        return const LogInWithLinkedinFailure();
    }
  }

  /// The associated error message.
  final String message;
}
