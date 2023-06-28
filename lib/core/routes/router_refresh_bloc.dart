part of 'router.dart';

class GoRouterRefreshBloc<AuthBloc extends BlocBase<AuthState>, AuthState>
    extends ChangeNotifier {
  GoRouterRefreshBloc(AuthBloc bloc) {
    _blocStream = bloc.stream.listen(
      (AuthState _) => notifyListeners(),
    );
  }

  late final StreamSubscription<AuthState> _blocStream;

  @override
  void dispose() {
    _blocStream.cancel();
    super.dispose();
  }
}
