import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/model/beer_model.dart';
import '../../../core/widgets/background.dart';
import 'widgets/image.dart';
import 'widgets/product_detail.dart';
import 'widgets/product_title.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen._({required this.currentItem});
  static Widget routeBuilder(BuildContext context, GoRouterState state) {
    return ProductDetailScreen._(currentItem: state.extra as Beer);
  }

  final Beer currentItem;
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Background(constraints: constraints),
                        ProductTitle(
                            name: widget.currentItem.name,
                            tagline: widget.currentItem.tagline),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                    color: Colors.white,
                    constraints: BoxConstraints(
                      minHeight: 450,
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CustomImage(
                          imageUrl: widget.currentItem.imageUrl,
                          maxHeight: constraints.maxHeight,
                          maxWidth: constraints.maxWidth,
                        ),
                        ProductDetail(
                            constraints: constraints,
                            currentItem: widget.currentItem),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
