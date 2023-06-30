import 'package:flutter/material.dart';

import '../../../../core/utils/assets.dart';

class BeerInfo extends StatelessWidget {
  const BeerInfo(
      {super.key, required this.title, required this.value, this.width});
  final String title;
  final double? width;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: width ?? 157, maxHeight: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(Assets.beer),
          SizedBox(
            width: 11,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: 5,
              ),
              Text(value,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Color(0xff77838F))),
            ],
          )
        ],
      ),
    );
  }
}
