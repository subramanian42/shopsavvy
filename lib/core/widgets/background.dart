import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({super.key, required this.constraints, this.height});
  final BoxConstraints constraints;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: constraints.maxWidth,
      constraints:
          BoxConstraints.loose(Size(constraints.maxWidth, height ?? 350)),
      decoration: BoxDecoration(
          color: Color(0xff1E2022),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16))),
    );
  }
}
