import 'package:shopsavvy/core/exceptions/exceptions.dart';
import 'package:test/test.dart';

void main() {
  group('LogInWithFacebookFailure', () {
    test('should create an instance with default message', () {
      final failure = const LogInWithFacebookFailure();
      expect(failure.message, 'An unknown exception occurred.');
    });

    test('should create an instance from exception code', () {
      final failure = LogInWithFacebookFailure.fromCode('OAuthException');
      expect(failure.message, 'Access Token expired');
    });

    test('should create an instance from unknown exception code', () {
      final failure = LogInWithFacebookFailure.fromCode('UnknownException');
      expect(failure.message, 'An unknown exception occurred.');
    });
  });
}
