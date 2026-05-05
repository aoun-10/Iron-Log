
import 'package:flutter/material.dart';

class GlassBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - 0.8;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3,
      1.2,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0
        ..strokeCap = StrokeCap.round
        ..color = Colors.white.withOpacity(0.2),
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0.1,
      1.3,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0
        ..strokeCap = StrokeCap.round
        ..color = Colors.white.withOpacity(0.2),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}