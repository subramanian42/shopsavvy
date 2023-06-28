import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shopsavvy/core/repository/auth_repository.dart';
import 'package:shopsavvy/core/theme/app_colors.dart';
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
          if (state.status == FormStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Fetch Data Success")),
            );
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0XFF1E2022),
          body: Column(
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
              const Text(
                'Sign in with',
                style: TextStyle(
                  color: Colors.white, //#1E2022
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  fontFamily: "SF Pro Text",
                ),
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
      onPressed: () {},
    );
  }
}
