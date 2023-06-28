part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AppLogoutRequested extends AuthEvent {}

class AppUserChanged extends AuthEvent {
  final UserModel user;

  AppUserChanged(this.user);
}
