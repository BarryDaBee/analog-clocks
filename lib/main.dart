import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(),
      home: const AnalogClock(),
    );
  }
}

class AnalogClock extends StatefulWidget {
  const AnalogClock({Key? key}) : super(key: key);

  @override
  State<AnalogClock> createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock> {
  DateTime dateTime = DateTime.now();

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (dateTime.second != DateTime.now().second) {
        setState(() {
          dateTime = DateTime.now();
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF292B3F),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Text(
              'Clock',
              style: GoogleFonts.josefinSans(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 50),
            Text(
              getTimeString(),
              style: GoogleFonts.josefinSans(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 50,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              getDate(),
              style: GoogleFonts.josefinSans(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 240,
                width: 240,
                child: CustomPaint(
                  painter: AnalogClock1(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getTimeString() {
    String hour = dateTime.hour.toString().padLeft(2, '0');
    String minute = dateTime.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  String getDate() {
    List<String> days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    List<String> months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    //print(dateTime.month);
    return '${days[dateTime.weekday]}, ${dateTime.day} ${months[dateTime.month - 1]}';
  }
}

class AnalogClock1 extends CustomPainter {
  //const AnalogClock1();

  @override
  void paint(Canvas canvas, Size size) {
    DateTime dateTime = DateTime.now();
    int minute = dateTime.minute;
    int second = dateTime.second;
    int hour = dateTime.hour;

    double centerX = size.width / 2;
    double centerY = size.height / 2;
    Offset center = Offset(centerX, centerY);
    double radius = min(centerX, centerY);
    Paint hourPaint = Paint()
      ..shader = ui.Gradient.linear(
        center,
        Offset.zero,
        const [
          Color(0xFFE974AB),
          Color(0xFFC679F7),
        ],
      )
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Paint minutePaint = Paint()
      ..shader = ui.Gradient.linear(
        center,
        const Offset(0, 0),
        const [Color(0xFF6D83E8), Color(0xFF78DBFF)],
      )
      ..strokeWidth = 7
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    Paint secondPaint = Paint()
      ..shader = ui.Gradient.linear(
        center,
        Offset.zero,
        const [
          Color(0xFFFEAF78),
          Color(0xFFFFC978),
        ],
      )
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(
      center,
      radius - 40,
      Paint()
        ..color = const Color(0xFF424775)
        ..style = PaintingStyle.fill,
    );
    canvas.drawCircle(
      center,
      radius - 40,
      Paint()
        ..color = Colors.white
        ..strokeWidth = 12
        ..style = PaintingStyle.stroke,
    );

    var hourHandX = centerX + 45 * sin((hour * 30 + (minute * 0.5)) * pi / 180);
    var hourHandY =
        centerY + 45 * -cos((hour * 30 + (minute * 0.5)) * pi / 180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourPaint);
    var minuteHandX = centerX + 60 * sin((minute * 6) * pi / 180);
    var minuteHandY = centerY + 60 * -cos((minute * 6) * pi / 180);
    canvas.drawLine(center, Offset(minuteHandX, minuteHandY), minutePaint);
    var secondHandX = centerX + 65 * sin(second * 6 * pi / 180);
    var secondHandY = centerY + 65 * -cos(second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secondHandX, secondHandY), secondPaint);
    canvas.drawCircle(center, 10, Paint()..color = Colors.white);

    var outerCircleRadius = radius;
    var innerCircleRadius = radius - 10;
    for (double i = 0; i < 360; i += 12) {
      var x1 = centerX + outerCircleRadius * cos(i * pi / 180);
      var y1 = centerX + outerCircleRadius * sin(i * pi / 180);

      var x2 = centerX + innerCircleRadius * cos(i * pi / 180);
      var y2 = centerX + innerCircleRadius * sin(i * pi / 180);
      canvas.drawLine(
          Offset(x1, y1),
          Offset(x2, y2),
          Paint()
            ..color = const Color(0xFF787CA1)
            ..strokeCap = StrokeCap.round
            ..strokeWidth = 2);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
