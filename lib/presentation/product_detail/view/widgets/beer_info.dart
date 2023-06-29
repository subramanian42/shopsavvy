import 'package:flutter/material.dart';

import '../../../../core/utils/assets.dart';

class BeerInfo extends StatelessWidget {
  const BeerInfo({super.key, required this.title, required this.value});
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 175, maxHeight: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(Assets.beer),
          SizedBox(
            width: 11,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
              Text(
                value,
                style: TextStyle(
                  color: Color(0xff77838F),
                  fontSize: 12,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
