import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ClockAnalogPainter extends CustomPainter {
  double size;
  double radius = 0;

  ClockAnalogPainter({required this.size}) {
    radius = size / 2;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    for (int i = 0; i < 60; i++) {
      double minute = 360 / 60 * i;
      paint.color = (i % 5 == 0) ? Colors.black : Colors.grey;
      paint.strokeWidth = (i % 5 == 0) ? 2 : 1;
      double distance = (i % 5 == 0) ? 25 : 5;

      double x1 = radius * cos(vector.radians(minute));
      double y1 = radius * sin(vector.radians(minute));
      final paint1 = Offset(x1, y1);

      double x2 = (radius - distance) * cos(vector.radians(minute));
      double y2 = (radius - distance) * sin(vector.radians(minute));
      final paint2 = Offset(x2, y2);

      canvas.drawLine(paint1, paint2, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
