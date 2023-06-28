import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    required this.logo,
    required this.title,
    required this.titleColor,
    required this.backgroundColor,
    required this.onPressed,
    super.key,
  });
  final VoidCallback? onPressed;
  final String logo;
  final String title;
  final Color titleColor;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      margin: const EdgeInsets.symmetric(horizontal: 18),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(backgroundColor),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          padding: const MaterialStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 64),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Image(
                image: AssetImage(logo),
              ),
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: titleColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  // fontFamily: "SF Pro Text",
                ),
              ),
            ),
            const SizedBox(
              width: 31,
            ),
          ],
        ),
      ),
    );
  }
}
