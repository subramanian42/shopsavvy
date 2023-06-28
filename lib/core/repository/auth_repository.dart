import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../exceptions/google_auth_exceptions.dart';
import '../model/user_model.dart';

class LogOutFailure implements Exception {}

class AuthRepository {
  AuthRepository({
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
    FacebookAuth? facebookSignIn,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  late final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  Stream<UserModel> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? UserModel.empty : firebaseUser.toUser;
      return user;
    });
  }

  UserModel get currentUser {
    return _firebaseAuth.currentUser?.toUser ?? UserModel.empty;
  }

  Future<void> loginWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw LogInWithGoogleFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithGoogleFailure();
    }
  }

  Future<void> loginWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final OAuthCredential credential =
            FacebookAuthProvider.credential(result.accessToken!.token);

        await FirebaseAuth.instance.signInWithCredential(credential);
      }
    } on FirebaseAuthException catch (e) {
      throw LogInWithGoogleFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithGoogleFailure();
    }
  }

  Future<void> logout() async {
    final socialSignInType =
        _firebaseAuth.currentUser?.providerData.first.providerId;
    _firebaseAuth.signOut();
    switch (socialSignInType) {
      case "google.com":
        await GoogleSignIn().signOut();
        break;
      case "facebook.com":
        await FacebookAuth.instance.logOut();
        break;

      default:
        // No social sign-in was performed.
        break;
    }
  }
}

extension on User {
  UserModel get toUser {
    return UserModel(
      id: uid,
      email: email,
      name: displayName,
      photo: photoURL,
    );
  }
}
