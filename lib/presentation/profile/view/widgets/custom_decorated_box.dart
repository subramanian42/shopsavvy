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
      margin: EdgeInsets.symmetric(horizontal: 12),
      padding: EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 28,
      ),
      child: Text(
        (title?.isEmpty ?? true) ? "not available" : title!,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      height: 75,
      decoration: ShapeDecoration(
        color: Theme.of(context).colorScheme.onTertiary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
