import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const collectionCardTitleStyle = TextStyle(color: Colors.purple, fontWeight: FontWeight.bold, fontSize: 24);

class CollectionCard extends StatelessWidget {
  final String title;
  final String id;
  final ImageProvider backgroundImage;
  
  const CollectionCard({
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
        height: 100,
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
            Center(
              child: Text(
                title, 
                style: collectionCardTitleStyle,)
            ),
          ],
        ),
      ),
    );
  }
}