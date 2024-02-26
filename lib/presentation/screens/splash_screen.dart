import 'dart:async';

import 'package:flutter/material.dart';
import 'package:laborex_distribution_app/presentation/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _circleScaleAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _logoOpacityAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _circleScaleAnimation = Tween<double>(begin: 0.0, end: 3.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceIn,
      ),
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 0.7).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInExpo,
      ),
    );
    _logoOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInExpo,
      ),
    );

    // Start the animation after a slight delay
    Timer(const Duration(milliseconds: 500),
        () => _animationController.forward());

    // Navigate to the next screen after the animation finishes
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(
          const Duration(milliseconds: 1500),
          () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Replace with your background color
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            ScaleTransition(
              scale: _circleScaleAnimation,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context)
                      .colorScheme
                      .primary, // Replace with your circle color
                ),
              ),
            ),
            ScaleTransition(
              scale: _scaleAnimation,
              child: FadeTransition(
                opacity: _logoOpacityAnimation,
                child: Image.asset(
                    'assets/logo.png'), // Replace with your logo image path
              ),
            ),
          ],
        ),
      ),
    );
  }
}
