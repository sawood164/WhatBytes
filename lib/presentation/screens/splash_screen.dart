import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wha_bytes/firebase_options.dart';
import 'package:wha_bytes/firebase_options.dart';
import 'package:wha_bytes/firebase_options.dart';
import 'package:wha_bytes/firebase_options.dart';
import 'package:wha_bytes/firebase_options.dart';
import 'package:wha_bytes/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wha_bytes/firebase_options.dart';

import '../../core/constants.dart';
import '../../core/transitions.dart';
import '../../services/auth_manager.dart';
import '../widgets/app_logo.dart';
import 'home.dart';
import 'login.dart';
import 'onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    ));

    _controller.forward().then((_) => _checkInitialRoute());
  }

  Future<void> _checkInitialRoute() async {
    final prefs = await SharedPreferences.getInstance();
    final showOnboarding = !(prefs.getBool(AppConstants.onboardingCompleteKey) ?? false);
    final isLoggedIn = await AuthManager.isLoggedIn();

    if (mounted) {
      Widget nextScreen;
      if (showOnboarding) {
        nextScreen = const OnboardingScreen();
      } else if (!isLoggedIn) {
        nextScreen = const LoginScreen();
      } else {
        nextScreen = const HomeScreen();
      }

      Navigator.pushReplacement(
        context,
        AppFadeTransition(page: nextScreen),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo animation
            FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: const AppLogo(
                  size: 160,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 32),
            // App name with animated text
            FadeTransition(
              opacity: _fadeAnimation,
              child: Text(
                AppConstants.appName,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 