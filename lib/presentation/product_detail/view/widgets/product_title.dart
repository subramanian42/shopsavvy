import 'package:flutter/material.dart';

import '../../../../core/widgets/back_button.dart';

class ProductTitle extends StatelessWidget {
  const ProductTitle({super.key, required this.name, required this.tagline});
  final String name;
  final String tagline;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomBackButton(),
        Container(
          margin: EdgeInsets.only(left: 14),
          child: Text(name,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Color(0xffAFB2B5))),
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          margin: EdgeInsets.only(left: 14),
          child: Text(tagline,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Color(0xffAFB2B5))),
        )
      ],
    );
  }
}
