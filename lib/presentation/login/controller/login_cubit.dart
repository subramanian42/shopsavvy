import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkedin_login/linkedin_login.dart';

import '../../../core/exceptions/exceptions.dart';
import '../../../core/repository/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authRepository) : super(LoginState());
  final AuthRepository _authRepository;

  void loginWithGoogle() async {
    try {
      await _authRepository.loginWithGoogle();

      emit(
        state.copyWith(
          status: FormStatus.success,
        ),
      );
    } on LogInWithGoogleFailure catch (e) {
      emit(
        state.copyWith(
          status: FormStatus.failure,
          errorMessage: e.message,
        ),
      );
    }
  }

  void loginWithFacebook() async {
    try {
      await _authRepository.loginWithFacebook();
      emit(
        state.copyWith(
          status: FormStatus.success,
        ),
      );
    } on LogInWithFacebookFailure catch (e) {
      emit(
        state.copyWith(
          status: FormStatus.failure,
          errorMessage: e.message,
        ),
      );
    }
  }

  void loginWithLinkedin({
    required UserSucceededAction response,
  }) async {
    try {
      await _authRepository.loginWithLinkedin(response);
      emit(
        state.copyWith(
          status: FormStatus.success,
        ),
      );
    } on LogInWithLinkedinFailure catch (e) {
      emit(
        state.copyWith(
          status: FormStatus.failure,
          errorMessage: e.message,
        ),
      );
    }
  }
}
