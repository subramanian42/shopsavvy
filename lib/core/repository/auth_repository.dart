import 'dart:developer';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:linkedin_login/linkedin_login.dart';

import '../exceptions/exceptions.dart';
import '../model/user_model.dart';

class LogOutFailure implements Exception {}

class AuthRepository {
  AuthRepository({
    FirebaseAuth? firebaseAuth,
    FacebookAuth? facebookAuth,
    FirebaseFunctions? firebaseFunctions,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard(),
        _facebookAuth = facebookAuth ?? FacebookAuth.instance,
        _firebaseFunctions = firebaseFunctions ?? FirebaseFunctions.instance;

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookAuth _facebookAuth;
  final FirebaseFunctions _firebaseFunctions;

  Stream<UserModel> get user {
    return _firebaseAuth.userChanges().map((firebaseUser) {
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
      await _firebaseAuth.signInWithCredential(credential);
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

        await _firebaseAuth.signInWithCredential(credential);
      }
    } on FirebaseAuthException catch (e) {
      throw LogInWithFacebookFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithFacebookFailure();
    }
  }

  Future<void> loginWithLinkedin(UserSucceededAction response) async {
    try {
      final linkedinUser = response.user;
      final uid = linkedinUser.userId;
      final email =
          linkedinUser.email?.elements?.first.handleDeep?.emailAddress;

      await Future.wait([
        _verifyEmail(email), // verify email is not linked to other providers
        _signInwithCustomToken(uid, email),
      ]);
      log("updating user Credentials...");
      await setUser(linkedinUser);
      log("successfully updated user Credentials...");
    } on FirebaseAuthException catch (e) {
      throw LogInWithLinkedinFailure.fromCode(e.code);
    } on LogInWithLinkedinFailure {
      rethrow;
    } catch (_) {
      throw LogInWithLinkedinFailure();
    }
  }

  Future<void> _signInwithCustomToken(String? uid, String? email) async {
    FirebaseFunctions functions = FirebaseFunctions.instance;
    HttpsCallable callable =
        functions.httpsCallable('createCustomToken'); // generate customToken
    final result = await callable.call<Map<String, dynamic>>(
      <String, dynamic>{'uid': uid, 'email': email},
    );

    final String value = result.data['token'] as String;
    await _firebaseAuth.signInWithCustomToken(value);
  }

  Future<void> setUser(LinkedInUserModel linkedinUser) async {
    final firstname = linkedinUser.firstName?.localized?.label;
    final lastname = linkedinUser.lastName?.localized?.label;
    final email = linkedinUser.email?.elements?.first.handleDeep?.emailAddress;
    final profileImageUrl = linkedinUser.profilePicture?.displayImageContent
        ?.elements?[0].identifiers?[0].identifier;

    log(linkedinUser.toString());

    await _firebaseAuth.currentUser!
        .updateDisplayName((firstname ?? "") + " " + (lastname ?? ""));

    await _firebaseAuth.currentUser!.updatePhotoURL(profileImageUrl);

    await _firebaseAuth.currentUser!.updateEmail(email ?? "");
  }

  Future<void> _verifyEmail(String? email) async {
    List<String> providers =
        await _firebaseAuth.fetchSignInMethodsForEmail(email ?? "");
    if (providers.isNotEmpty)
      throw LogInWithLinkedinFailure.fromCode("email-already-in-use");
  }

  Future<void> logout() async {
    String socialSignInType = "";
    if (_firebaseAuth.currentUser?.providerData.isNotEmpty ?? false)
      socialSignInType =
          _firebaseAuth.currentUser?.providerData[0].providerId ?? "";
    await _firebaseAuth.signOut();
    switch (socialSignInType) {
      case "google.com":
        await _googleSignIn.signOut();
        break;
      case "facebook.com":
        await FacebookAuth.instance.logOut();
        break;
      default:
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
