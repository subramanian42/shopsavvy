part of 'login_cubit.dart';

enum FormStatus { initial, success, failure }

class LoginState {
  const LoginState({
    this.status = FormStatus.initial,
    this.errorMessage,
  });
  final FormStatus status;
  final String? errorMessage;
  LoginState copyWith({
    FormStatus? status,
    bool? isValid,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
