// ignore_for_file: prefer_const_constructors
import 'package:shopsavvy/presentation/login/login.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoginState', () {
    test('supports value comparisons', () {
      expect(LoginState(), LoginState());
    });

    test('returns same object when no properties are passed', () {
      expect(LoginState().copyWith(), LoginState());
    });

    test('returns object with updated status when status is passed', () {
      expect(
        LoginState().copyWith(status: LoginStatus.initial),
        LoginState(),
      );
    });
    test('returns object with updated message when errormessage is passed', () {
      expect(
        LoginState().copyWith(status: LoginStatus.initial),
        LoginState(),
      );
    });
  });
}
