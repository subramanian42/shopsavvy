import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  const CustomImage(
      {super.key,
      required this.imageUrl,
      required this.maxHeight,
      required this.maxWidth});
  final double maxHeight;
  final double maxWidth;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -maxHeight * 0.20,
      left: maxWidth * 1 / 3.5,
      child: Container(
        width: maxWidth * 1 / 2.25,
        height: maxHeight * 0.30,
        padding: EdgeInsets.fromLTRB(31, 19, 31, 13),
        decoration: BoxDecoration(
          color: Color(0xffD8D8D8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Image.network(
          imageUrl,
        ),
      ),
    );
  }
}
