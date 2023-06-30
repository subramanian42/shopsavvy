import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/model/beer_model.dart';
import '../../../core/widgets/background.dart';
import 'widgets/image.dart';
import 'widgets/more_info.dart';
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
        body: LayoutBuilder(builder: (context, constraints) {
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
                        _productDetail(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }));
  }

  Widget _productDetail() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 14.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 95,
          ),
          Text(
            "Description",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(
            height: 11,
          ),
          Container(
            margin: const EdgeInsets.only(
              right: 14.0,
            ),
            child: Text(
              widget.currentItem.description,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Color(0xff77838F)),
            ),
          ),
          SizedBox(
            height: 22,
          ),
          Text(
            "First Brewed",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(
            height: 11,
          ),
          Text(widget.currentItem.firstBrewed,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Color(0xff77838F))),
          SizedBox(
            height: 22,
          ),
          Text("Getting to know your beer better",
              style: Theme.of(context).textTheme.titleLarge),
          SizedBox(
            height: 22,
          ),
          MoreInfo(
            currentItem: widget.currentItem,
          ),
          SizedBox(
            height: 34,
          ),
        ],
      ),
    );
  }
}
