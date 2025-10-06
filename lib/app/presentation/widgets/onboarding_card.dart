import 'package:flutter/material.dart';

class OnboardingCard extends StatelessWidget {
  final PageController pageController;
  final int index;
  final String imagePath;

  const OnboardingCard({
    Key? key,
    required this.pageController,
    required this.index,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, child) {
        double value = 0;
        if (pageController.position.haveDimensions) {
          value = pageController.page! - index;
        } else {
          value = pageController.initialPage - index.toDouble();
        }
        value = value.clamp(-1, 1);

        final scale = 1 - (value.abs() * 0.2);
        final rotationY = value * 0.5;

        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(rotationY),
          alignment: Alignment.center,
          child: Transform.scale(
            scale: scale,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
