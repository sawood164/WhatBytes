import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wha_bytes/firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants.dart';
import '../../core/transitions.dart';
import '../widgets/animated_button.dart';
import 'login.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  void _completeOnboarding(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.onboardingCompleteKey, true);
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        AppFadeTransition(page: const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Spacer(),
              Lottie.asset(
                'assets/animations/animation_1.json',
                height: 300,
              ),
              const SizedBox(height: 40),
              Text(
                'Task Manager',
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Organize and track your gigs efficiently with our task manager',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              AnimatedButton(
                onPressed: () => _completeOnboarding(context),
                text: 'Get Started',
                icon: Icons.arrow_forward,
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
} 