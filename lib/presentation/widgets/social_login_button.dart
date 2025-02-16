import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SocialLoginButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String logoPath;
  final SocialButtonType type;

  const SocialLoginButton({
    super.key,
    required this.onPressed,
    required this.logoPath,
    required this.type,
  });

  @override
  State<SocialLoginButton> createState() => _SocialLoginButtonState();
}

class _SocialLoginButtonState extends State<SocialLoginButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _handleTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final buttonStyle = widget.type.getStyle();

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                height: 48,
                width: 48,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _isHovered ? buttonStyle.hoverColor : buttonStyle.backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: buttonStyle.borderColor,
                    width: 1.5,
                  ),
                  boxShadow: _isHovered
                      ? [
                          BoxShadow(
                            color: buttonStyle.shadowColor.withOpacity(0.2),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ]
                      : null,
                ),
                child: Image.asset(
                  widget.logoPath,
                  height: 24,
                  width: 24,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

enum SocialButtonType { google, apple, facebook }

extension SocialButtonStyle on SocialButtonType {
  ButtonStyle getStyle() {
    switch (this) {
      case SocialButtonType.google:
        return ButtonStyle(
          backgroundColor: Colors.white,
          hoverColor: const Color(0xFFF8F9FA),
          textColor: const Color(0xFF1F1F1F),
          iconColor: const Color(0xFF1F1F1F),
          borderColor: const Color(0xFFE8EAED),
          shadowColor: const Color(0xFF1F1F1F),
        );
      case SocialButtonType.apple:
        return ButtonStyle(
          backgroundColor: Colors.black,
          hoverColor: const Color(0xFF1A1A1A),
          textColor: Colors.white,
          iconColor: Colors.white,
          borderColor: Colors.black,
          shadowColor: Colors.black,
        );
      case SocialButtonType.facebook:
        return ButtonStyle(
          backgroundColor: const Color(0xFF1877F2),
          hoverColor: const Color(0xFF166FE5),
          textColor: Colors.white,
          iconColor: Colors.white,
          borderColor: const Color(0xFF1877F2),
          shadowColor: const Color(0xFF1877F2),
        );
    }
  }
}

class ButtonStyle {
  final Color backgroundColor;
  final Color hoverColor;
  final Color textColor;
  final Color iconColor;
  final Color borderColor;
  final Color shadowColor;

  const ButtonStyle({
    required this.backgroundColor,
    required this.hoverColor,
    required this.textColor,
    required this.iconColor,
    required this.borderColor,
    required this.shadowColor,
  });
} 