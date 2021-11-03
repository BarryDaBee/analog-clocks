import 'dart:math';

import 'package:flutter/material.dart';

class Clock1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    DateTime dateTime = DateTime.now();

    double centerX = size.width / 2;
    double centerY = size.height / 2;
    Offset center = Offset(centerX, centerY);
    double radius = min(centerX, centerY);

    Paint handPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF292B3F),
    );
    // canvas.drawCircle(
    //   center,
    //   radius,
    //   Paint()
    //     ..style = PaintingStyle.stroke
    //     ..color = const Color(0xFF1F2131)
    //     ..strokeWidth = 10,
    // );

    // canvas.drawArc(
    //   Rect.fromCircle(center: center, radius: radius),
    //   dateTime.second * 6 * pi / 180, //radians
    //   (6.28319 * dateTime.second / 60),
    //   false,
    //   Paint()
    //     ..color = Colors.yellow
    //     ..strokeWidth = 10
    //     ..strokeCap = StrokeCap.round
    //     ..style = PaintingStyle.stroke,
    // );

    canvas.drawCircle(
      center,
      radius - 20,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFF1F2131),
    );

    double minuteHandX =
        centerX + (radius - 45) * sin(dateTime.minute * 6 * pi / 180);
    double minuteHandY =
        centerY + (radius - 45) * -cos(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minuteHandX, minuteHandY), handPaint);
    double hourHandX = centerX +
        (radius - 75) *
            sin((dateTime.hour * 30 + dateTime.minute * 0.1) * pi / 180);

    double hourHandY = centerY +
        (radius - 75) *
            -cos((dateTime.hour * 30 + dateTime.minute * 0.1) * pi / 180);
    canvas.drawLine(
        center, Offset(hourHandX, hourHandY), handPaint..strokeWidth = 4);
    canvas.drawCircle(
        center,
        7,
        Paint()
          ..color = Colors.white
          ..strokeWidth = 2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
