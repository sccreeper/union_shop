import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {

  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text("About Us", style: Theme.of(context).textTheme.headlineLarge,),
          const Text("Welcome to the Union Shop! \nAll purchases are made available for delivery or instore collection! \nHappy shopping!"),
        ],
      ),
    );
  }

}