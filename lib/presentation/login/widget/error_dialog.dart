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
          Text('Oops! Something went wrong.',
              style: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(color: Theme.of(context).colorScheme.error)
              // TextStyle(fontSize: 20),
              ),
          const SizedBox(height: 16),
          Text(
            "Here is what happened \n\n$errorMessage",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Theme.of(context).colorScheme.tertiary),
          ),
          const SizedBox(height: 16),
          if (onPressed != null) ...{
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onPressed,
              child: Text('Reload',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.background)),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          },
        ],
      ),
    );
  }
}
