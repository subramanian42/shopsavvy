import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shopsavvy/core/repository/product_repository.dart';

import 'package:shopsavvy/core/widgets/custom_loader.dart';
import 'package:shopsavvy/presentation/home/view/widgets/profile_icon.dart';

import '../home.dart';
import 'widgets/bottom_loader.dart';
import 'widgets/product_list_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen._();

  static Widget routeBuilder(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) {
        return HomeBloc(productRepository: context.read<ProductRepository>()) //
          ..add(FetchItems());
      },
      child: const HomeScreen._(),
    );
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  final _gridScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF1E2022),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ProfileIcon(),
            Container(
              margin: EdgeInsets.only(left: 14, bottom: 20),
              child: Text(
                "Time to Cheers! Choose your beer...",
                style: TextStyle(
                  color: Color(0xffAFB2B5),
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
            _buildProductList(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductList() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return switch (state.status) {
          FetchStatus.success => _buildProductGrid(state),
          FetchStatus.failure => _failedToLoad(state),
          FetchStatus.initial => CustomLoader()
        };
      },
    );
  }

  Widget _buildProductGrid(HomeState state) {
    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          controller: _gridScrollController,
          padding: EdgeInsets.symmetric(horizontal: 16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 28,
            crossAxisSpacing: 14,
            mainAxisExtent: 298,
          ),
          itemCount: state.beers.length,
          itemBuilder: (context, index) {
            return GridItem(beer: state.beers[index]);
          },
        ),
        SizedBox(
          height: 15,
        ),
        if (_isBottom) ...{
          BottomLoader(),
        },
      ],
    );
  }

  Widget _failedToLoad(HomeState state) {
    return Container(
      child: Center(
        child:
            Text("The Following Error occoured\n" + (state.errorMessage ?? "")),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<HomeBloc>().add(FetchItems());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
