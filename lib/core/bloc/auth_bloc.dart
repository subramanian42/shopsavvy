import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/user_model.dart';
import '../repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  AuthBloc({required AuthRepository authenticationRepository})
      : _authRepository = authenticationRepository,
        super(
          authenticationRepository.currentUser.isNotEmpty
              ? AuthState.authenticated(authenticationRepository.currentUser)
              : const AuthState.unauthenticated(),
        ) {
    on<AppUserChanged>(onAppUserChanged);
    on<AppLogoutRequested>(onAppLogoutRequested);
    _userSubscription = _authRepository.user.listen(
      (user) => add(AppUserChanged(user)),
    );
  }
  late final StreamSubscription<UserModel> _userSubscription;

  void onAppUserChanged(AppUserChanged event, Emitter<AuthState> emit) async {
    emit(event.user.isNotEmpty
        ? AuthState.authenticated(event.user)
        : const AuthState.unauthenticated());
  }

  void onAppLogoutRequested(
      AppLogoutRequested event, Emitter<AuthState> emit) async {
    _authRepository.logout();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
