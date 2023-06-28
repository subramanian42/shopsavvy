import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/repository/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authRepository) : super(LoginState());
  final AuthRepository _authRepository;

  void loginWithGoogle() {
    _authRepository.loginWithGoogle();
  }

  void loginWithFacebook() {
    _authRepository.loginWithFacebook();
  }
}
