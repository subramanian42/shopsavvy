import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key, required this.width, required this.onPressed});
  final double width;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        child: Text(
          'Logout',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'SF Pro Text',
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.red),
          fixedSize: MaterialStatePropertyAll(Size(width, 75)),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        onPressed: onPressed,
      ),
      width: width,
      height: 75,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(20),
      // ),
      margin: EdgeInsets.symmetric(horizontal: 18),
    );
  }
}
