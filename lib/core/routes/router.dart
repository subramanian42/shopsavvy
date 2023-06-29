import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';

import 'dart:async';

import '../../presentation/home/view/home_screen.dart';
import '../../presentation/login/login.dart';
import '../../presentation/login/widget/linkedin_redirect.dart';
import '../../presentation/not_found/not_found_screen.dart';

import '../../presentation/product_detail/view/product_detail_screen.dart';
import '../../presentation/profile/profile.dart';
import '../bloc/auth_bloc.dart';

part 'router_refresh_bloc.dart';

class AppRouter {
  static GoRouter router(BuildContext ctx) => GoRouter(
        debugLogDiagnostics: true,
        initialLocation: '/',
        redirect: (context, state) {
          final authState = BlocProvider.of<AuthBloc>(context).state;
          final bool loggingIn = state.matchedLocation == '/login' ||
              state.matchedLocation.isEmpty;
          if (state.matchedLocation == "/linkedin" &&
              authState.status == AppStatus.unauthenticated) return "/linkedin";
          if (authState.status == AppStatus.unauthenticated) {
            return '/login';
          }

          if (loggingIn) {
            return '/';
          }
          return null;
        },
        refreshListenable: GoRouterRefreshBloc<AuthBloc, AuthState>(
          BlocProvider.of<AuthBloc>(ctx),
        ),
        routes: [
          GoRoute(path: '/', builder: HomeScreen.routeBuilder, routes: [
            GoRoute(
              path: 'productdetail',
              builder: ProductDetailScreen.routeBuilder,
            ),
          ]),
          GoRoute(
            path: '/login',
            builder: LoginScreen.routeBuilder,
          ),
          GoRoute(
            path: '/linkedin',
            builder: LinkedinRedirect.routeBuilder,
          ),
          GoRoute(
            path: '/profile',
            builder: ProfileScreen.routeBuilder,
          )
        ],
        errorBuilder: (context, state) => const NotFoundScreen(),
      );
}
