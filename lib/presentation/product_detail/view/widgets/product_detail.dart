import 'package:flutter/material.dart';

import '../../../../core/model/beer_model.dart';
import 'more_info.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({
    required this.constraints,
    required this.currentItem,
    super.key,
  });
  final BoxConstraints constraints;
  final Beer currentItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 14.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: constraints.maxHeight * 0.15,
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
              currentItem.description,
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
          Text(currentItem.firstBrewed,
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
            currentItem: currentItem,
          ),
          SizedBox(
            height: 34,
          ),
        ],
      ),
    );
  }
}
