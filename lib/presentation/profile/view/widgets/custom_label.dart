import 'package:flutter/material.dart';

class CustomLabel extends StatelessWidget {
  const CustomLabel({super.key, required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        color: Color(0xff979797),
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
