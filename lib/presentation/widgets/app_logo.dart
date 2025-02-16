import 'package:flutter/material.dart';
import 'dart:math' as math;

class AppLogo extends StatefulWidget {
  final double size;
  final Color? color;

  const AppLogo({
    super.key,
    this.size = 80,
    this.color,
  });

  @override
  State<AppLogo> createState() => _AppLogoState();
}

class _AppLogoState extends State<AppLogo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.7, curve: Curves.easeInOut),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 1.0, curve: Curves.elasticOut),
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? Theme.of(context).colorScheme.primary;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Transform.rotate(
            angle: _rotationAnimation.value,
            child: CustomPaint(
              size: Size(widget.size, widget.size),
              painter: LogoPainter(color: color),
            ),
          ),
        );
      },
    );
  }
}

class LogoPainter extends CustomPainter {
  final Color color;

  LogoPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.08
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.35;

    // Draw outer circle
    canvas.drawCircle(center, radius, paint);

    // Draw checkmark
    final path = Path();
    final checkStart = Offset(
      center.dx - radius * 0.5,
      center.dy + radius * 0.1,
    );
    path.moveTo(checkStart.dx, checkStart.dy);
    path.lineTo(
      center.dx - radius * 0.1,
      center.dy + radius * 0.5,
    );
    path.lineTo(
      center.dx + radius * 0.6,
      center.dy - radius * 0.3,
    );

    canvas.drawPath(path, paint);

    // Draw rays
    final rayPaint = Paint()
      ..color = color.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.04
      ..strokeCap = StrokeCap.round;

    for (var i = 0; i < 8; i++) {
      final angle = i * math.pi / 4;
      final rayStart = Offset(
        center.dx + math.cos(angle) * (radius * 1.3),
        center.dy + math.sin(angle) * (radius * 1.3),
      );
      final rayEnd = Offset(
        center.dx + math.cos(angle) * (radius * 1.5),
        center.dy + math.sin(angle) * (radius * 1.5),
      );
      canvas.drawLine(rayStart, rayEnd, rayPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
} 