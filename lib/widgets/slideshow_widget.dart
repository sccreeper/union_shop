import 'package:flutter/material.dart';

class Slideshow extends StatefulWidget {
  final List<String> imagePaths;

  const Slideshow({super.key, required this.imagePaths});

  @override
  State<StatefulWidget> createState() {
    return _SlideshowState();
  }
}

class _SlideshowState extends State<Slideshow> {
  int _currentIndex = 0;

  void _nextSlide() {
    if (_currentIndex + 1 < widget.imagePaths.length) {
      setState(() {
        _currentIndex++;
      });
    } else {
      setState(() {
        _currentIndex = 0;
      });
    }
  }

  void _previousSlide() {
    if (_currentIndex - 1 >= 0) {
      setState(() {
        _currentIndex--;
      });
    } else {
      setState(() {
        _currentIndex = widget.imagePaths.length - 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              widget.imagePaths[_currentIndex],
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Text("Error rendering image"),
                );
              },
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: _previousSlide,
                      icon: const Icon(Icons.arrow_left)),
                  IconButton(
                      onPressed: _nextSlide, icon: const Icon(Icons.arrow_right)),
                ],
              ))
        ],
      ),
    );
  }
}
