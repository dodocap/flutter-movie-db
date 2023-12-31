import 'package:flutter/material.dart';

class ErrorScreenWidget extends StatelessWidget {
  final String error;
  final void Function() callback;

  const ErrorScreenWidget({
    super.key,
    required this.error,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: callback,
            icon: const Icon(Icons.refresh),
          ),
          Text(
            error,
            style: const TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
