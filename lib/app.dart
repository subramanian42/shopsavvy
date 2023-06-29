import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'core/bloc/auth_bloc.dart';
import 'core/clients/punk_api_client.dart';
import 'core/repository/auth_repository.dart';
import 'core/repository/product_repository.dart';
import 'core/routes/router.dart';

class ShopSavvy extends StatefulWidget {
  const ShopSavvy({super.key});

  @override
  State<ShopSavvy> createState() => _ShopSavvyState();
}

class _ShopSavvyState extends State<ShopSavvy> {
  late final PunkApiClient _client;
  late final AuthRepository _authRepo;
  @override
  void initState() {
    super.initState();

    _client = PunkApiClient();
    _authRepo = AuthRepository();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>.value(value: _authRepo),
        RepositoryProvider<ProductRepository>(
            create: (context) => ProductRepository(_client)),
      ],
      child: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(authenticationRepository: _authRepo),
        child: ShopSavvyView(),
      ),
    );
  }
}

class ShopSavvyView extends StatefulWidget {
  const ShopSavvyView({super.key});

  @override
  State<ShopSavvyView> createState() => _ShopSavvyViewState();
}

class _ShopSavvyViewState extends State<ShopSavvyView> {
  late final GoRouter _router;
  @override
  void initState() {
    super.initState();
    _router = AppRouter.router(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      routeInformationProvider: _router.routeInformationProvider,
    );
  }
}
