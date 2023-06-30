part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginWithGoogle extends LoginEvent {}

class LoginWithFacebook extends LoginEvent {}

class LoginWithLinkedin extends LoginEvent {
  UserSucceededAction response;

  LoginWithLinkedin(this.response);
}
