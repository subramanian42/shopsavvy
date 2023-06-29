import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'package:shopsavvy/presentation/login/controller/login_cubit.dart';

class LinkedinRedirect extends StatefulWidget {
  const LinkedinRedirect._();
  static Widget routeBuilder(BuildContext context, GoRouterState state) {
    return BlocProvider<LoginCubit>.value(
      value: state.extra as LoginCubit,
      child: LinkedinRedirect._(),
    );
  }

  @override
  State<LinkedinRedirect> createState() => _LinkedinRedirectState();
}

class _LinkedinRedirectState extends State<LinkedinRedirect> {
  bool session = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LinkedInUserWidget(
          onGetUserProfile: (response) {
            context.read<LoginCubit>().loginWithLinkedin(response: response);
            context.pop();
          },
          redirectUrl: "http://localhost:8080/shopsavvy/auth/linkedin",
          clientId: const String.fromEnvironment("clientId"),
          clientSecret: const String.fromEnvironment("clientSecret"),
          destroySession: true,
          onError: (error) {
            context.pop();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  error.exception.toString(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
