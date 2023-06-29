import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/assets.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pop(),
      child: Container(
        height: 36,
        width: 36,
        margin: EdgeInsets.only(left: 14, top: 48, bottom: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: AssetImage(Assets.backButton),
            ),
            color: Colors.white),
      ),
    );
  }
}
