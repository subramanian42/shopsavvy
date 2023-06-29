import 'package:flutter/material.dart';

class CustomProfileImage extends StatelessWidget {
  const CustomProfileImage(
      {super.key,
      required this.imageUrl,
      required this.maxHeight,
      required this.maxWidth});
  final double maxHeight;
  final double maxWidth;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    // return Container();
    return Positioned(
      top: -maxHeight * 0.20,
      left: maxWidth * 1 / 3.5,
      child: Container(
        width: 50, //maxWidth * 1 / 2.25,
        height: 200, //maxHeight * 0.30,
        padding: EdgeInsets.fromLTRB(31, 19, 31, 13),
        decoration: BoxDecoration(
          color: Color(0xffD8D8D8),
          borderRadius: BorderRadius.circular(20),
        ),
        // child:
        //     // imageUrl == null
        //     // ?
        //     Image.asset(
        //   Assets.profilePlaceholder,
        // )
        // : Image.network(imageUrl!)
      ),
    );
  }
}
