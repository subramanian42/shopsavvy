// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'package:shopsavvy/core/exceptions/exceptions.dart';
import 'package:shopsavvy/core/repository/auth_repository.dart';
import 'package:shopsavvy/presentation/login/login.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockUserSuccededAction extends Mock implements UserSucceededAction {}

void main() {
  group('LoginBloc', () {
    late AuthRepository authRepository;
    late UserSucceededAction successResponse;

    setUp(() {
      authRepository = MockAuthRepository();
      successResponse = MockUserSuccededAction();
      when(
        () => authRepository.loginWithGoogle(),
      ).thenAnswer((_) async {});
      when(
        () => authRepository.loginWithFacebook(),
      ).thenAnswer((_) async {});
      when(
        () => authRepository.loginWithLinkedin(successResponse),
      ).thenAnswer((_) async {});
    });

    test('initial state is LoginState', () {
      expect(LoginBloc(authRepository).state, LoginState());
    });

    group('logInWithGoogle', () {
      blocTest<LoginBloc, LoginState>(
        'calls logInWithGoogle',
        build: () => LoginBloc(authRepository),
        act: (bloc) => bloc.add(LoginWithGoogle()),
        verify: (_) {
          verify(() => authRepository.loginWithGoogle()).called(1);
        },
      );

      blocTest<LoginBloc, LoginState>(
        'emits [inProgress, success] '
        'when logInWithGoogle succeeds',
        build: () => LoginBloc(authRepository),
        act: (bloc) => bloc.add(LoginWithGoogle()),
        expect: () => const <LoginState>[
          LoginState(status: LoginStatus.loading),
          LoginState(status: LoginStatus.success)
        ],
      );

      blocTest<LoginBloc, LoginState>(
        'emits [loading, failure] '
        'when logInWithGoogle fails due to LogInWithGoogleFailure',
        setUp: () {
          when(
            () => authRepository.loginWithGoogle(),
          ).thenThrow(LogInWithGoogleFailure('oops'));
        },
        build: () => LoginBloc(authRepository),
        act: (bloc) => bloc.add(LoginWithGoogle()),
        expect: () => const <LoginState>[
          LoginState(status: LoginStatus.loading),
          LoginState(
            status: LoginStatus.failure,
            errorMessage: 'oops',
          )
        ],
      );

      blocTest<LoginBloc, LoginState>(
        'emits [loading, failure] '
        'when logInWithGoogle fails due to generic exception',
        setUp: () {
          when(
            () => authRepository.loginWithGoogle(),
          ).thenThrow(Exception('oops'));
        },
        build: () => LoginBloc(authRepository),
        act: (bloc) => bloc.add(LoginWithGoogle()),
        expect: () => const <LoginState>[
          LoginState(status: LoginStatus.loading),
          LoginState(status: LoginStatus.failure)
        ],
      );
    });
    group('logInWithFacebook', () {
      blocTest<LoginBloc, LoginState>(
        'calls logInWithFacebook',
        build: () => LoginBloc(authRepository),
        act: (bloc) => bloc.add(LoginWithFacebook()),
        verify: (_) {
          verify(() => authRepository.loginWithFacebook()).called(1);
        },
      );

      blocTest<LoginBloc, LoginState>(
        'emits [inProgress, success] '
        'when logInWithFacebook succeeds',
        build: () => LoginBloc(authRepository),
        act: (bloc) => bloc.add(LoginWithFacebook()),
        expect: () => const <LoginState>[
          LoginState(status: LoginStatus.loading),
          LoginState(status: LoginStatus.success)
        ],
      );

      blocTest<LoginBloc, LoginState>(
        'emits [loading, failure] '
        'when logInWithFacebook fails due to LogInWithFacebookFailure',
        setUp: () {
          when(
            () => authRepository.loginWithFacebook(),
          ).thenThrow(LogInWithFacebookFailure('oops'));
        },
        build: () => LoginBloc(authRepository),
        act: (bloc) => bloc.add(LoginWithFacebook()),
        expect: () => const <LoginState>[
          LoginState(status: LoginStatus.loading),
          LoginState(
            status: LoginStatus.failure,
            errorMessage: 'oops',
          )
        ],
      );

      blocTest<LoginBloc, LoginState>(
        'emits [loading, failure] '
        'when logInWithFacebook fails due to generic exception',
        setUp: () {
          when(
            () => authRepository.loginWithFacebook(),
          ).thenThrow(Exception('oops'));
        },
        build: () => LoginBloc(authRepository),
        act: (bloc) => bloc.add(LoginWithFacebook()),
        expect: () => const <LoginState>[
          LoginState(status: LoginStatus.loading),
          LoginState(status: LoginStatus.failure)
        ],
      );
    });
    group('logInWithLinkedin', () {
      blocTest<LoginBloc, LoginState>(
        'calls logInWithLinkedin',
        build: () => LoginBloc(authRepository),
        act: (bloc) => bloc.add(LoginWithLinkedin(successResponse)),
        verify: (_) {
          verify(() => authRepository.loginWithLinkedin(successResponse))
              .called(1);
        },
      );

      blocTest<LoginBloc, LoginState>(
        'emits [inProgress, success] '
        'when logInWithLinkedin succeeds',
        build: () => LoginBloc(authRepository),
        act: (bloc) => bloc.add(LoginWithLinkedin(successResponse)),
        expect: () => const <LoginState>[
          LoginState(status: LoginStatus.loading),
          LoginState(status: LoginStatus.success)
        ],
      );

      blocTest<LoginBloc, LoginState>(
        'emits [loading, failure] '
        'when logInWithLinkedin fails due to LogInWithLinkedinFailure',
        setUp: () {
          when(
            () => authRepository.loginWithLinkedin(successResponse),
          ).thenThrow(LogInWithLinkedinFailure('oops'));
        },
        build: () => LoginBloc(authRepository),
        act: (bloc) => bloc.add(LoginWithLinkedin(successResponse)),
        expect: () => const <LoginState>[
          LoginState(status: LoginStatus.loading),
          LoginState(
            status: LoginStatus.failure,
            errorMessage: 'oops',
          )
        ],
      );

      blocTest<LoginBloc, LoginState>(
        'emits [loading, failure] '
        'when logInWithLinkedin fails due to generic exception',
        setUp: () {
          when(
            () => authRepository.loginWithLinkedin(successResponse),
          ).thenThrow(Exception('oops'));
        },
        build: () => LoginBloc(authRepository),
        act: (bloc) => bloc.add(LoginWithLinkedin(successResponse)),
        expect: () => const <LoginState>[
          LoginState(status: LoginStatus.loading),
          LoginState(status: LoginStatus.failure)
        ],
      );
    });
  });
}
