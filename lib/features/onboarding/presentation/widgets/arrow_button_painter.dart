import 'dart:math';

import 'package:flutter/material.dart';
import 'package:onboarding/index.dart';

class ArrowButtonPainter extends CustomPainter {
  final double pageIndex;

  ArrowButtonPainter(this.pageIndex);

  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double outterRadius = max(centerX, centerY);
    double innerWidth = (outterRadius - 8) * 2;

    canvas.drawCircle(
      Offset(centerX, centerY),
      outterRadius,
      Paint()
        ..color = AppColors.white40
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.0,
    );
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(centerX, centerY),
        width: size.width,
        height: size.height,
      ),
      3 * pi / 2,
      pi / 2 * pageIndex,
      false,
      Paint()
        ..color = AppColors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.0,
    );

    final arrowPath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromPoints(
            Offset(centerX - 5, centerY - 5),
            Offset(centerX + 3, centerY - 3),
          ),
          const Radius.circular(1),
        ),
      )
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromPoints(
            Offset(centerX + 3, centerY - 5),
            Offset(centerX + 1, centerY + 3),
          ),
          const Radius.circular(1),
        ),
      );

    final circlePath = Path()
      ..addOval(
        Rect.fromCenter(
          center: Offset(centerX, centerY),
          width: innerWidth,
          height: innerWidth,
        ),
      );
    final circlePaint = Paint()
      ..color = AppColors.white
      ..style = PaintingStyle.fill;

    final innerButtonPath =
        Path.combine(PathOperation.difference, circlePath, arrowPath);

    canvas.translate(centerX, 0);
    canvas.rotate(pi / 4);
    canvas.translate(-centerX / sqrt(10), -centerY / sqrt(10));
    canvas.drawPath(innerButtonPath, circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
