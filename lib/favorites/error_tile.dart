import 'package:flutter/material.dart';

class ErrorTile extends StatelessWidget {
  const ErrorTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.error,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Center(
        child: Icon(Icons.error, color: Theme.of(context).colorScheme.onError),
      ),
    );
  }
}
