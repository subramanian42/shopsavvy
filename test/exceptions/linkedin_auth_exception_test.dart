import 'package:shopsavvy/core/exceptions/exceptions.dart';
import 'package:test/test.dart';

void main() {
  group('LogInWithlinkedinFailure', () {
    test('should create an instance with default message', () {
      final failure = const LogInWithLinkedinFailure();
      expect(failure.message, 'An unknown exception occurred.');
    });

    test('should create an instance from exception code', () {
      final failure = LogInWithLinkedinFailure.fromCode('invalid-custom-token');
      expect(failure.message, 'The Access token in invalid');
    });

    test('should create an instance from unknown exception code', () {
      final failure = LogInWithLinkedinFailure.fromCode('UnknownException');
      expect(failure.message, 'An unknown exception occurred.');
    });
  });
}
