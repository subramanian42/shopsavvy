part of 'login_bloc.dart';

enum LoginStatus { initial, success, failure, loading }

class LoginState {
  const LoginState({
    this.status = LoginStatus.initial,
    this.errorMessage,
  });
  final LoginStatus status;
  final String? errorMessage;
  LoginState copyWith({
    LoginStatus? status,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
