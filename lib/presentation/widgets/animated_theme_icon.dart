import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wha_bytes/firebase_options.dart';

import '../../services/theme_manager.dart';

class AnimatedThemeIcon extends StatelessWidget {
  const AnimatedThemeIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeManager>(
      builder: (context, themeManager, _) {
        return IconButton(
          onPressed: () => themeManager.toggleTheme(),
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return RotationTransition(
                turns: animation,
                child: FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              );
            },
            child: Icon(
              themeManager.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              key: ValueKey<bool>(themeManager.isDarkMode),
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
} 