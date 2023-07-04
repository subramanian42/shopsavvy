import 'package:go_router/go_router.dart';
import 'package:shopsavvy/core/bloc/auth_bloc.dart';
import 'package:shopsavvy/core/model/user_model.dart';
import 'package:shopsavvy/core/repository/auth_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsavvy/app.dart';
import 'package:shopsavvy/core/repository/product_repository.dart';
import 'package:shopsavvy/presentation/home/home.dart';
import 'package:shopsavvy/presentation/login/login.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUser extends Mock implements UserModel {}

class MockAuthRepository extends Mock implements AuthRepository {}

class MockProductRepository extends Mock implements ProductRepository {}

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

class MockGoRouter extends Mock implements GoRouter {}

void main() {
  group('App', () {
    late AuthRepository authRepository;
    late ProductRepository productRepository;
    late UserModel user;

    setUp(() {
      authRepository = MockAuthRepository();
      productRepository = MockProductRepository();
      user = MockUser();
      when(() => authRepository.user).thenAnswer(
        (_) => const Stream.empty(),
      );
      when(() => authRepository.currentUser).thenReturn(user);
      when(() => user.isNotEmpty).thenReturn(true);
      when(() => user.isEmpty).thenReturn(false);
      when(() => user.email).thenReturn('test@gmail.com');
    });

    testWidgets('render view', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          ShopSavvy(
            authRepository: authRepository,
            productRepository: productRepository,
          ),
        );
        expect(find.byType(ShopSavvyView), findsOneWidget);
      });
    });
  });

  group('AppView', () {
    late AuthRepository authRepository;
    late ProductRepository productRepository;
    late AuthBloc appBloc;

    setUp(() {
      authRepository = MockAuthRepository();
      productRepository = MockProductRepository();
      appBloc = MockAuthBloc();
    });

    testWidgets('navigates to LoginPage when unauthenticated', (tester) async {
      when(() => appBloc.state).thenReturn(const AuthState.unauthenticated());
      await tester.pumpWidget(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider.value(value: authRepository),
            RepositoryProvider.value(value: productRepository),
          ],
          child: MaterialApp(
            home: BlocProvider.value(
              value: appBloc,
              child: const ShopSavvyView(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byType(LoginScreen), findsOneWidget);
    });

    testWidgets('navigates to HomePage when authenticated', (tester) async {
      final user = MockUser();
      when(() => user.email).thenReturn('test@gmail.com');
      when(() => appBloc.state).thenReturn(AuthState.authenticated(user));
      await tester.pumpWidget(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider.value(value: authRepository),
            RepositoryProvider.value(value: productRepository),
          ],
          child: MaterialApp(
            home: BlocProvider.value(
              value: appBloc,
              child: const ShopSavvyView(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}
