class LogInWithFacebookFailure implements Exception {
  const LogInWithFacebookFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithFacebookFailure.fromCode(String code) {
    switch (code) {
      case 'OAuthException':
        return const LogInWithFacebookFailure(
          'Access Token expired',
        );
      case '102':
        return const LogInWithFacebookFailure(
          'The credential received is malformed or has expired.',
        );
      case '1' && '2':
        return const LogInWithFacebookFailure(
          'Server is down try again later',
        );

      case '3':
        return const LogInWithFacebookFailure(
          'All the necessary permissions were not given',
        );
      case '4':
        return const LogInWithFacebookFailure(
          'Too many Calls to the server',
        );
      case '464':
        return const LogInWithFacebookFailure(
          'The is not verified',
        );
      case '10':
        return const LogInWithFacebookFailure(
          'App permission denied',
        );
      default:
        return const LogInWithFacebookFailure();
    }
  }

  /// The associated error message.
  final String message;
}
