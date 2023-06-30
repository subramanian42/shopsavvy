import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({super.key, required this.constraints, this.height});
  final BoxConstraints constraints;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: constraints.maxWidth,
      constraints: BoxConstraints.loose(
        Size(
          constraints.maxWidth,
          height ?? constraints.maxHeight * 0.45,
        ),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
        ),
      ),
    );
  }
}
