import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkedin_login/linkedin_login.dart';

import '../../../core/exceptions/exceptions.dart';
import '../../../core/repository/auth_repository.dart';

part 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._authRepository) : super(LoginState()) {
    on<LoginWithGoogle>(onLoginWithGoogle);

    on<LoginWithLinkedin>(onLoginWithLinkedin);
    on<LoginWithFacebook>(onLoginWithFacebook);
  }
  final AuthRepository _authRepository;

  void onLoginWithGoogle(
      LoginWithGoogle event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(
        status: LoginStatus.loading,
      ));
      await _authRepository.loginWithGoogle();

      emit(
        state.copyWith(
          status: LoginStatus.success,
        ),
      );
    } on LogInWithGoogleFailure catch (e) {
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: e.message,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: LoginStatus.failure));
    }
  }

  void onLoginWithLinkedin(
      LoginWithLinkedin event, Emitter<LoginState> emit) async {
    try {
      emit(
        state.copyWith(
          status: LoginStatus.loading,
        ),
      );
      await _authRepository.loginWithLinkedin(event.response);
      emit(
        state.copyWith(
          status: LoginStatus.success,
        ),
      );
    } on LogInWithLinkedinFailure catch (e) {
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: e.message,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: LoginStatus.failure));
    }
  }

  void onLoginWithFacebook(
      LoginWithFacebook event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(
        status: LoginStatus.loading,
      ));
      await _authRepository.loginWithFacebook();
      emit(
        state.copyWith(
          status: LoginStatus.success,
        ),
      );
    } on LogInWithFacebookFailure catch (e) {
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: e.message,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: LoginStatus.failure));
    }
  }
}
