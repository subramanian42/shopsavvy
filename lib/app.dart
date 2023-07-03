import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shopsavvy/core/theme/theme.dart';

import 'core/bloc/auth_bloc.dart';
import 'core/repository/auth_repository.dart';
import 'core/repository/product_repository.dart';
import 'core/routes/router.dart';

class ShopSavvy extends StatefulWidget {
  const ShopSavvy({
    super.key,
    required AuthRepository authRepository,
    required ProductRepository productRepository,
  })  : _authRepo = authRepository,
        _productRepo = productRepository;
  final AuthRepository _authRepo;
  final ProductRepository _productRepo;
  @override
  State<ShopSavvy> createState() => _ShopSavvyState();
}

class _ShopSavvyState extends State<ShopSavvy> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>.value(value: widget._authRepo),
        RepositoryProvider<ProductRepository>.value(value: widget._productRepo),
      ],
      child: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(authRepository: widget._authRepo),
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
      theme: AppTheme.getTheme,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      routeInformationProvider: _router.routeInformationProvider,
    );
  }
}
