import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HeaderSlideshowItem {
  final String title;
  final String subtitle;
  final String buttonText;
  final String route;
  final String imagePath;

  const HeaderSlideshowItem(
      {required this.title, required this.subtitle, required this.buttonText, required this.route, required this.imagePath});
}

class HeaderSlideshow extends StatefulWidget {
  final List<HeaderSlideshowItem> slideshowItems;

  const HeaderSlideshow({super.key, required this.slideshowItems});

  @override
  State<StatefulWidget> createState() => _HeaderSlideshowState();
}

class _HeaderSlideshowState extends State<HeaderSlideshow> {
  int _currentIndex = 0;

  void _nextSlide() {
    if (_currentIndex + 1 < widget.slideshowItems.length) {
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
        _currentIndex = widget.slideshowItems.length - 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: Image.asset(
                  widget.slideshowItems[_currentIndex].imagePath,
                ).image,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
              ),
            ),
          ),
        ),
        // Content overlay
        Positioned(
          left: 24,
          right: 24,
          top: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.slideshowItems[_currentIndex].title,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.slideshowItems[_currentIndex].subtitle,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  context.go(widget.slideshowItems[_currentIndex].route);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4d2963),
                  foregroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: Text(
                  widget.slideshowItems[_currentIndex].buttonText,
                  style: const TextStyle(fontSize: 14, letterSpacing: 1),
                ),
              ),
            ],
          ),
        ),

        // Movement buttons
        Positioned(
          bottom: 8,
          left: 8,
          right: 8,
          child: Row(
            children: [
              IconButton.filled(onPressed: _previousSlide, icon: const Icon(Icons.arrow_left)),
              const Spacer(),
              IconButton.filled(onPressed: _nextSlide, icon: const Icon(Icons.arrow_right)),
            ],
          ),
        )
      ],
    );
  }
}
