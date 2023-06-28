import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

import '../../presentation/login/login.dart';
import '../../presentation/not_found/not_found_screen.dart';

part 'router_refresh_bloc.dart';

class AppRouter {
  static GoRouter router(BuildContext ctx) => GoRouter(
        debugLogDiagnostics: true,
        initialLocation: '/login',
        routes: [
          GoRoute(
            path: '/login',
            builder: LoginScreen.routeBuilder,
          ),
        ],
        errorBuilder: (context, state) => const NotFoundScreen(),
      );
}
