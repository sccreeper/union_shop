import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorPage extends StatelessWidget {
  final String errorMessage;

  const ErrorPage({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(errorMessage),
          ElevatedButton(
              onPressed: () {
                context.go("/");
              },
              child: const Text("Home"))
        ],
      ),
    );
  }
}
