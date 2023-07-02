import 'package:flutter/material.dart';

import '../../../../core/utils/assets.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage(
      {super.key, required this.constraints, required this.imageUrl});
  final BoxConstraints constraints;
  final String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: constraints.maxHeight * 0.175,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: constraints.maxWidth * 0.175,
        ),
        decoration: BoxDecoration(
          color: Color(0xffD8D8D8),
          borderRadius: BorderRadius.circular(20),
          image: imageUrl == null
              ? DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    Assets.profilePlaceholder,
                  ),
                )
              : DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(imageUrl!),
                ),
        ),
        constraints: BoxConstraints(
          maxHeight: constraints.maxWidth * 0.675,
          maxWidth: constraints.maxWidth * 0.675,
        ),
      ),
    );
  }
}
