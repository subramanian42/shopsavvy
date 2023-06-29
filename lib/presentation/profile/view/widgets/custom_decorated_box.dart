import 'package:flutter/material.dart';

class CustomDecoratedBox extends StatelessWidget {
  const CustomDecoratedBox(
      {super.key, required this.title, required this.width});
  final String? title;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: EdgeInsets.symmetric(horizontal: 18),
      padding: EdgeInsets.only(left: 11, top: 28, bottom: 28),
      child: Text(
        title ?? "NA",
        style: TextStyle(
          color: Color(0xFF1E2022),
          fontSize: 16,
          fontFamily: 'SF Pro Text',
          fontWeight: FontWeight.w700,
          letterSpacing: 1,
        ),
      ),
      height: 75,
      decoration: ShapeDecoration(
        color: Color(0xFFEEEEEE),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
