import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key, this.onPressed, this.errorMessage});
  final void Function()? onPressed;
  final String? errorMessage;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Oops! Something went wrong.',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 16),
          Text(
            "Here is what happened \n$errorMessage",
            textAlign: TextAlign.center,
          ),
          if (onPressed != null) ...{
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onPressed,
              child: const Text('Refresh'),
            ),
          },
        ],
      ),
    );
  }
}
