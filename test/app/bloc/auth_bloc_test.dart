// ignore_for_file: prefer_const_constructors, must_be_immutable
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shopsavvy/core/bloc/auth_bloc.dart';
import 'package:shopsavvy/core/model/user_model.dart';
import 'package:shopsavvy/core/repository/auth_repository.dart';

import 'package:flutter_test/flutter_test.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockUser extends Mock implements UserModel {}

void main() {
  group('AuthBloc', () {
    final user = MockUser();
    late AuthRepository authRepository;

    setUp(() {
      authRepository = MockAuthRepository();
      when(() => authRepository.user).thenAnswer(
        (_) => Stream.empty(),
      );
      when(
        () => authRepository.currentUser,
      ).thenReturn(UserModel.empty);
    });

    test('initial state is unauthenticated when user is empty', () {
      expect(
        AuthBloc(authRepository: authRepository).state,
        AuthState.unauthenticated(),
      );
    });

    group('UserChanged', () {
      blocTest<AuthBloc, AuthState>(
        'emits authenticated when user is not empty',
        setUp: () {
          when(() => user.isNotEmpty).thenReturn(true);
          when(() => authRepository.user).thenAnswer(
            (_) => Stream.value(user),
          );
        },
        build: () => AuthBloc(
          authRepository: authRepository,
        ),
        seed: AuthState.unauthenticated,
        expect: () => [AuthState.authenticated(user)],
      );

      blocTest<AuthBloc, AuthState>(
        'emits unauthenticated when user is empty',
        setUp: () {
          when(() => authRepository.user).thenAnswer(
            (_) => (Stream.value(UserModel.empty)),
          );
        },
        build: () => AuthBloc(
          authRepository: authRepository,
        ),
        expect: () => [AuthState.unauthenticated()],
      );
    });

    group('LogoutRequested', () {
      blocTest<AuthBloc, AuthState>(
        'invokes logOut',
        setUp: () {
          when(
            () => authRepository.logout(),
          ).thenAnswer(
            (_) async {},
          );
        },
        build: () => AuthBloc(
          authRepository: authRepository,
        ),
        act: (bloc) => bloc.add(AppLogoutRequested()),
        verify: (_) {
          verify(() => authRepository.logout()).called(1);
        },
      );
    });
  });
}
