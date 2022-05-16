import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' show radians;

class ClockFacePainter extends CustomPainter {
  final DateTime time;

  final Color color;
  final Color foregroundColor;

  ClockFacePainter({required this.time, required this.color, required this.foregroundColor});

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.shortestSide / 2;

    final paint = Paint();
    paint
      ..style = PaintingStyle.fill
      ..color = color;

    canvas.save();
    // 1. we bring the center to (0,0)
    canvas.translate(size.width / 2, size.height / 2);
    // 2. we rotate it -90deg so the quadrant +x and +y comes top
    canvas.rotate(-pi / 2);

    canvas.drawCircle(const Offset(0, 0), radius, paint);

    final handPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..color = foregroundColor
      ..strokeJoin = StrokeJoin.round;

    // Draw hour hand
    canvas.save();

    final hourRadians = radians(time.hour * 30);

    canvas.rotate(hourRadians);

    final hourPath = Path()
      ..moveTo(-4, 0)
      ..lineTo(10, 0)
      ..close();

    canvas.drawPath(hourPath, handPaint..strokeWidth = 2);

    canvas.restore();

    // Draw minute hand
    canvas.save();

    final minuteRadians = radians(time.minute * 6);

    canvas.rotate(minuteRadians);

    final minutePath = Path()
      ..moveTo(-4, 0)
      ..lineTo(16, 0)
      ..close();

    canvas.drawPath(minutePath, handPaint..strokeWidth = 1.2);

    canvas.restore();

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant ClockFacePainter oldDelegate) {
    return oldDelegate.time.hour != time.hour || oldDelegate.time.minute != time.minute;
  }
}
