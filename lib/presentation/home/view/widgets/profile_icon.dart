import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/assets.dart';

class ProfileIcon extends StatelessWidget {
  const ProfileIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/profile'),
      child: Container(
        height: 36,
        width: 36,
        margin: EdgeInsets.only(left: 14, top: 48, bottom: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: AssetImage(Assets.profile),
            ),
            color: Colors.white),
      ),
    );
  }
}
