import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const TextField(decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Email"
          ),),
          
          const SizedBox(height: 8.0,),
          
          const TextField(decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Password"
          ),),
          
          const SizedBox(height: 8.0,),

          ElevatedButton.icon(
            onPressed: () => {},
            icon: const Icon(Icons.login),
            label: const Text("Login"),
          )
        ],
      ),
    );
  }

}