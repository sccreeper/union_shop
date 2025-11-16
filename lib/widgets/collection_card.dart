import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CollectionCard extends StatelessWidget {
  final String title;
  final String id;
  final ImageProvider backgroundImage;
  
  CollectionCard({
    super.key,
    required this.title,
    required this.id,
    required this.backgroundImage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go('/collection/$id'),
      child: SizedBox(
        height: 50,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ColorFiltered(
              colorFilter: const ColorFilter.mode(
                Colors.grey,
                BlendMode.saturation,
              ),
              child: Image(image: backgroundImage, fit: BoxFit.cover,),
            ),
            Text(title, style: const TextStyle(color: Colors.white, height: 24),)
          ],
        ),
      ),
    );
  }
}