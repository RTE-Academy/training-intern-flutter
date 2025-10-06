import 'package:flutter/material.dart';
import '../widgets/onboarding_card.dart';
import '../widgets/enter_button.dart';

class OnboardingPage extends StatefulWidget {
  final String username;
  const OnboardingPage({super.key, required this.username});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late final PageController _pageController;

  final List<String> images = [
    'assets/images/m1.png',
    'assets/images/m2.png',
    'assets/images/m3.png',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),

            // PageView
            Expanded(
              flex: 6,
              child: PageView.builder(
                controller: _pageController,
                itemCount: images.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return OnboardingCard(
                    pageController: _pageController,
                    index: index,
                    imagePath: images[index],
                  );
                },
              ),
            ),

            const Spacer(flex: 1),

            const Text(
              'Onboarding',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Watch everything you want\nfor free!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 40),

            EnterButton(username: widget.username),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
