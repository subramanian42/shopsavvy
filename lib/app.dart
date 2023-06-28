import 'package:flutter/material.dart';

class ShopSavvy extends StatefulWidget {
  const ShopSavvy({super.key});

  @override
  State<ShopSavvy> createState() => _ShopSavvyState();
}

class _ShopSavvyState extends State<ShopSavvy> {

  @override
  Widget build(BuildContext context) {
    return ShopSavvy();
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
