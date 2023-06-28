import 'package:flutter/material.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Screen Not Found',
          style: TextStyle(
            fontSize: 32,
          ),
        ),
      ),
    );
  }
}
