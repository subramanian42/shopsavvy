import 'package:shopsavvy/core/exceptions/exceptions.dart';
import 'package:test/test.dart';

void main() {
  group('LogInWithGoogleFailure', () {
    test('should create an instance with default message', () {
      final failure = const LogInWithGoogleFailure();
      expect(failure.message, 'An unknown exception occurred.');
    });

    test('should create an instance from exception code', () {
      final failure = LogInWithGoogleFailure.fromCode('user-not-found');
      expect(failure.message, 'Email is not found, please create an account.');
    });

    test('should create an instance from unknown exception code', () {
      final failure = LogInWithGoogleFailure.fromCode('UnknownException');
      expect(failure.message, 'An unknown exception occurred.');
    });
  });
}
