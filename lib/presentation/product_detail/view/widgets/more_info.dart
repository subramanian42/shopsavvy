import 'package:flutter/material.dart';
import 'package:shopsavvy/presentation/product_detail/view/widgets/beer_info.dart';

import '../../../../core/model/beer_model.dart';

class MoreInfo extends StatelessWidget {
  const MoreInfo({super.key, required this.currentItem});
  final Beer currentItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BeerInfo(title: "ABV", value: currentItem.abv),
            SizedBox(height: 22),
            BeerInfo(title: "Target FG", value: currentItem.targetFg),
            SizedBox(height: 22),
            BeerInfo(title: "EBC", value: currentItem.ebc),
            SizedBox(height: 22),
            BeerInfo(title: "PH", value: currentItem.ph),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BeerInfo(title: "IBU", value: currentItem.ibu),
            SizedBox(height: 22),
            BeerInfo(title: "TARGET OG", value: currentItem.targetOg),
            SizedBox(height: 22),
            BeerInfo(title: "SRM", value: currentItem.srm),
            SizedBox(height: 22),
            BeerInfo(
                title: "ATTENUATION LEVEL",
                width: 202,
                value: currentItem.attenuationLevel),
          ],
        ),
      ],
    );
  }
}
