// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shopsavvy/core/bloc/auth_bloc.dart';
import 'package:shopsavvy/core/model/user_model.dart';

class MockUser extends Mock implements UserModel {}

void main() {
  group('AppState', () {
    group('unauthenticated', () {
      test('has correct status', () {
        final state = AuthState.unauthenticated();
        expect(state.status, AppStatus.unauthenticated);
        expect(state.user, UserModel.empty);
      });
    });

    group('authenticated', () {
      test('has correct status', () {
        final user = MockUser();
        final state = AuthState.authenticated(user);
        expect(state.status, AppStatus.authenticated);
        expect(state.user, user);
      });
    });
  });
}
