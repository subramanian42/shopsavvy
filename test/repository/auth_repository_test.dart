// ignore_for_file: must_be_immutable
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'package:shopsavvy/core/exceptions/exceptions.dart';
import 'package:shopsavvy/core/model/user_model.dart';
import 'package:shopsavvy/core/repository/auth_repository.dart';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

const _mockFirebaseUserUid = 'mock-uid';
const _mockFirebaseUserEmail = 'mock-email';

class MockFirebaseAuth extends Mock implements firebase_auth.FirebaseAuth {}

class MockFirebaseCore extends Mock
    with MockPlatformInterfaceMixin
    implements FirebasePlatform {}

class MockFirebaseUser extends Mock implements firebase_auth.User {}

class MockUserSucceededAction extends Mock implements UserSucceededAction {}

class MockLinkedinUserModel extends Mock implements LinkedInUserModel {}

class MockLinkedinProfileEmail extends Mock implements LinkedInProfileEmail {
  @override
  List<LinkedInDeepEmail>? get elements => [
        LinkedInDeepEmail(
            handleDeep: LinkedInDeepEmailHandle(emailAddress: "test@gmail.com"))
      ];
}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockHttpsCallable extends Mock implements HttpsCallable {}

class MockHttpsCallableResult<T> extends Mock
    implements HttpsCallableResult<T> {}

class MockFirebaseFunctions extends Mock implements FirebaseFunctions {}

class MockFacebookSignIn extends Mock implements FacebookAuth {}

class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

class MockGoogleSignInAuthentication extends Mock
    implements GoogleSignInAuthentication {}

class MockUserCredential extends Mock implements firebase_auth.UserCredential {}

class FakeAuthCredential extends Fake implements firebase_auth.AuthCredential {}

class FakeAuthProvider extends Fake implements AuthProvider {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const user = UserModel(
    id: _mockFirebaseUserUid,
    email: _mockFirebaseUserEmail,
  );

  group('AuthenticationRepository', () {
    late firebase_auth.FirebaseAuth firebaseAuth;
    late GoogleSignIn googleSignIn;
    late FacebookAuth facebookSignIn;
    late FirebaseFunctions firebaseFunctions;
    late AuthRepository authRepository;
    const String googleSigninType = "google.com";
    const String facebookSigninType = "facebook.com";

    setUpAll(() {
      registerFallbackValue(FakeAuthCredential());
      registerFallbackValue(FakeAuthProvider());
    });

    setUp(() {
      const options = FirebaseOptions(
        apiKey: 'apiKey',
        appId: 'appId',
        messagingSenderId: 'messagingSenderId',
        projectId: 'projectId',
      );
      final platformApp = FirebaseAppPlatform(defaultFirebaseAppName, options);
      final firebaseCore = MockFirebaseCore();
      firebaseFunctions = MockFirebaseFunctions();

      when(() => firebaseCore.apps).thenReturn([platformApp]);
      when(firebaseCore.app).thenReturn(platformApp);
      when(
        () => firebaseCore.initializeApp(
          name: defaultFirebaseAppName,
          options: options,
        ),
      ).thenAnswer((_) async => platformApp);

      Firebase.delegatePackingProperty = firebaseCore;

      firebaseAuth = MockFirebaseAuth();
      googleSignIn = MockGoogleSignIn();
      facebookSignIn = MockFacebookSignIn();
      authRepository = AuthRepository(
        firebaseAuth: firebaseAuth,
        googleSignIn: googleSignIn,
        facebookAuth: facebookSignIn,
        firebaseFunctions: firebaseFunctions,
      );
    });

    test('creates FirebaseAuth instance internally when not injected', () {
      expect(AuthRepository.new, isNot(throwsException));
    });

    group('login', () {
      group('loginWithGoogle', () {
        const accessToken = 'access-token';
        const idToken = 'id-token';

        setUp(() {
          final googleSignInAuthentication = MockGoogleSignInAuthentication();
          final googleSignInAccount = MockGoogleSignInAccount();
          when(() => googleSignInAuthentication.accessToken)
              .thenReturn(accessToken);
          when(() => googleSignInAuthentication.idToken).thenReturn(idToken);
          when(() => googleSignInAccount.authentication)
              .thenAnswer((_) async => googleSignInAuthentication);
          when(() => googleSignIn.signIn())
              .thenAnswer((_) async => googleSignInAccount);
          when(() => firebaseAuth.signInWithCredential(any()))
              .thenAnswer((_) => Future.value(MockUserCredential()));
        });

        test('calls signIn authentication, and signInWithCredential', () async {
          await authRepository.loginWithGoogle();
          verify(() => googleSignIn.signIn()).called(1);
          verify(() => firebaseAuth.signInWithCredential(any())).called(1);
        });

        test('succeeds when signIn succeeds', () {
          expect(authRepository.loginWithGoogle(), completes);
        });

        test('throws LogInWithGoogleFailure when exception occurs', () async {
          when(() => firebaseAuth.signInWithCredential(any()))
              .thenThrow(Exception());
          expect(
            authRepository.loginWithGoogle(),
            throwsA(isA<LogInWithGoogleFailure>()),
          );
        });
      });
      group('loginWithLinkedin', () {
        late UserSucceededAction response;
        late LinkedInUserModel userModel;
        late LinkedInProfileEmail emailModel;
        late HttpsCallable httpsCallable;
        late HttpsCallableResult<Map<String, dynamic>> httpsCallableResult;
        const uid = "userid";
        const email = "test@gmail.com";
        setUp(() {
          response = MockUserSucceededAction();
          userModel = MockLinkedinUserModel();
          emailModel = MockLinkedinProfileEmail();
          httpsCallable = MockHttpsCallable();
          httpsCallableResult = MockHttpsCallableResult<Map<String, dynamic>>();
          when(() => response.user).thenReturn(userModel);
          when(() => userModel.userId).thenReturn(uid);
          when(() => userModel.email).thenReturn(emailModel);
          when(() => firebaseFunctions.httpsCallable('createCustomToken'))
              .thenReturn(httpsCallable);
          when(() => httpsCallable.call<Map<String, dynamic>>(
                  <String, dynamic>{'uid': uid, 'email': email}))
              .thenAnswer((_) => Future.value(httpsCallableResult));
          when(() => httpsCallableResult.data)
              .thenReturn({"token": 'my_token'});
          when(() => firebaseAuth.fetchSignInMethodsForEmail(email))
              .thenAnswer((_) => Future.value([]));
          when(() => firebaseAuth.signInWithCustomToken(any()))
              .thenAnswer((_) => Future.value(MockUserCredential()));
        });
        test('calls signIn authentication, and signInWithCustomToken',
            () async {
          await authRepository.loginWithLinkedin(response);
          verify(() => firebaseAuth.fetchSignInMethodsForEmail(email))
              .called(1);
          verify(() => firebaseAuth.signInWithCustomToken(any())).called(1);
        });

        test('succeeds when signIn succeeds', () {
          expect(authRepository.loginWithLinkedin(response), completes);
        });

        test('throws LogInWithGoogleFailure when exception occurs', () async {
          when(() => firebaseAuth.signInWithCustomToken(any()))
              .thenThrow(Exception());
          expect(
            authRepository.loginWithLinkedin(response),
            throwsA(isA<LogInWithLinkedinFailure>()),
          );
        });
      });
    });

    group('logOut', () {
      test('calls google signout', () async {
        when(() => firebaseAuth.signOut()).thenAnswer((_) async {});
        when(() => googleSignIn.signOut()).thenAnswer((_) async => null);
        await authRepository.logout(signinType: googleSigninType);
        verify(() => firebaseAuth.signOut()).called(1);
        verify(() => googleSignIn.signOut()).called(1);
      });
      test('calls facebook signout', () async {
        when(() => firebaseAuth.signOut()).thenAnswer((_) async {});
        when(() => facebookSignIn.logOut()).thenAnswer((_) async => null);
        await authRepository.logout(signinType: facebookSigninType);
        verify(() => firebaseAuth.signOut()).called(1);
        verify(() => facebookSignIn.logOut()).called(1);
      });
      test('throws LogoutFailure when signout throws', () async {
        when(() => firebaseAuth.signOut()).thenThrow(Exception());
        expect(
          authRepository.logout(),
          throwsA(isA<LogoutFailure>()),
        );
      });
    });

    group('user Model', () {
      test('emits User.empty when firebase user is null', () async {
        when(() => firebaseAuth.userChanges())
            .thenAnswer((_) => Stream.value(null));
        await expectLater(
          authRepository.user,
          emitsInOrder(const <UserModel>[UserModel.empty]),
        );
      });

      test('emits User when firebase user is not null', () async {
        final firebaseUser = MockFirebaseUser();
        when(() => firebaseUser.uid).thenReturn(_mockFirebaseUserUid);
        when(() => firebaseUser.email).thenReturn(_mockFirebaseUserEmail);
        when(() => firebaseUser.photoURL).thenReturn(null);
        when(() => firebaseAuth.userChanges())
            .thenAnswer((_) => Stream.value(firebaseUser));
        await expectLater(
          authRepository.user,
          emitsInOrder(const <UserModel>[user]),
        );
      });
    });
  });
}
