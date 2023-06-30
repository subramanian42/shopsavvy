import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shopsavvy/core/repository/auth_repository.dart';
import 'package:shopsavvy/core/theme/app_colors.dart';
import 'package:shopsavvy/presentation/login/widget/error_dialog.dart';
import 'package:shopsavvy/presentation/login/widget/sign_in_button.dart';

import '../../core/utils/assets.dart';

import 'controller/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen._();
  static Widget routeBuilder(BuildContext context, GoRouterState state) {
    return BlocProvider<LoginBloc>(
      create: (context) {
        return LoginBloc(context.read<AuthRepository>());
      },
      child: const LoginScreen._(),
    );
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status == LoginStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(
                "Login Success",
              )),
            );
          }
          if (state.status == LoginStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(
                state.errorMessage!,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
              )),
            );
          }
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state.status == LoginStatus.loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state.status == LoginStatus.failure) {
                return Center(
                  child: ErrorDialog(
                    errorMessage: state.errorMessage,
                    onPressed: () =>
                        context.read<LoginBloc>().add(LoginReset()),
                  ),
                );
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Image(
                      image: AssetImage(Assets.appIconLarge),
                    ),
                  ),
                  const SizedBox(
                    height: 88,
                  ),
                  Text('Sign in with',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.white)),
                  const SizedBox(
                    height: 23,
                  ),
                  _googleSignIn(),
                  const SizedBox(
                    height: 16,
                  ),
                  // _facebookSignIn(),
                  const SizedBox(
                    height: 16,
                  ),
                  _linkedinSignIn(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _googleSignIn() {
    return SignInButton(
      logo: Assets.googleIconSmall,
      title: "Google",
      titleColor: AppColors.darkBlue,
      backgroundColor: AppColors.white,
      onPressed: () => context.read<LoginBloc>().add(LoginWithGoogle()),
    );
  }

//Meta now requires all NEWLY entered package names to be associated with a valid google play store URL https://developers.facebook.com/support/bugs/1307870196812047/?join_id=f12e5a3b52a432
  Widget _facebookSignIn() {
    return SignInButton(
      logo: Assets.facebookIconSmall,
      title: "Facebook",
      titleColor: AppColors.white,
      backgroundColor: const Color(0xFF3D6AD6),
      onPressed: () {},
    );
  }

  Widget _linkedinSignIn() {
    return SignInButton(
      logo: Assets.linkedinIconSmall,
      title: "Linkedin",
      titleColor: AppColors.white,
      backgroundColor: const Color(0xFF0077B5),
      onPressed: () =>
          context.push('/linkedin', extra: BlocProvider.of<LoginBloc>(context)),
    );
  }
}
