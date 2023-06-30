import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shopsavvy/core/repository/auth_repository.dart';
import 'package:shopsavvy/core/theme/app_colors.dart';
import 'package:shopsavvy/presentation/login/widget/error_dialog.dart';
import 'package:shopsavvy/presentation/login/widget/sign_in_button.dart';

import '../../core/utils/assets.dart';

import 'controller/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen._();
  static Widget routeBuilder(BuildContext context, GoRouterState state) {
    return BlocProvider<LoginCubit>(
      create: (context) {
        return LoginCubit(context.read<AuthRepository>());
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
      child: BlocListener<LoginCubit, LoginState>(
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
          body: BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              if (state.status == LoginStatus.loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state.status == LoginStatus.failure) {
                return ErrorDialog(
                  errorMessage: state.errorMessage,
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
                          .copyWith(color: Colors.white)
                      // TextStyle(
                      //   color: Colors.white,
                      //   fontWeight: FontWeight.w700,
                      //   fontSize: 16,
                      //   fontFamily: "SF Pro Text",
                      // ),
                      ),
                  const SizedBox(
                    height: 23,
                  ),
                  _googleSignIn(),
                  const SizedBox(
                    height: 16,
                  ),
                  _facebookSignIn(),
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
      onPressed: () => context.read<LoginCubit>().loginWithGoogle(),
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
      onPressed: () => context.push('/linkedin',
          extra: BlocProvider.of<LoginCubit>(context)),
    );
  }
}
