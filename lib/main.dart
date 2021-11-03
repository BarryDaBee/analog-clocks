import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
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
      home: const AnalogClock1(),
    );
  }
}

class AnalogClock0 extends StatefulWidget {
  const AnalogClock0({Key? key}) : super(key: key);

  @override
  State<AnalogClock0> createState() => _AnalogClock0State();
}

class _AnalogClock0State extends State<AnalogClock0> {
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
              child: Stack(
                children: [
                  SizedBox(
                    height: 240,
                    width: 240,
                    child: CircularProgressIndicator(
                      backgroundColor: const Color(0xFF1F2131),
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.yellow.shade600),
                      strokeWidth: 20,
                      value: (dateTime.second.toDouble() / 60 * 1),
                    ),
                  ),
                  SizedBox(
                    height: 240,
                    width: 240,
                    child: CustomPaint(
                      painter: Clock1(),
                    ),
                  ),
                ],
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

class AnalogClock1 extends StatefulWidget {
  const AnalogClock1({Key? key}) : super(key: key);

  @override
  State<AnalogClock1> createState() => _AnalogClock1State();
}

class _AnalogClock1State extends State<AnalogClock1> {
  DateTime dateTime = DateTime.now();
  bool shouldRepeat = true;
  bool isSilent = false;
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
    // TODO: implement build

    return Scaffold(
      backgroundColor: const Color(0xFF292B3F),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 70),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Alarm',
                textAlign: TextAlign.center,
                style: GoogleFonts.josefinSans(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 30,
                ),
              ),
            ),
            const SizedBox(height: 60),
            Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  SizedBox(
                    height: 240,
                    width: 240,
                    child: CircularProgressIndicator(
                      backgroundColor: const Color(0xFF1F2131),
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.yellow.shade600),
                      strokeWidth: 20,
                      value: (dateTime.second.toDouble() / 60 * 1),
                    ),
                  ),
                  SizedBox(
                    height: 240,
                    width: 240,
                    child: CustomPaint(
                      painter: Clock1(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Text(
              getTimeString(),
              style: GoogleFonts.josefinSans(
                color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: 50,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Repeat',
                  style: GoogleFonts.josefinSans(
                    color: Colors.white,
                    fontWeight: FontWeight.w200,
                    fontSize: 24,
                  ),
                ),
                CupertinoSwitch(
                  activeColor: Colors.yellow[600],
                  thumbColor: const Color(0xFF1F2131),
                  onChanged: (bool value) {
                    setState(() {
                      shouldRepeat = value;
                    });
                  },
                  value: shouldRepeat,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Silent',
                  style: GoogleFonts.josefinSans(
                    color: Colors.white,
                    fontWeight: FontWeight.w200,
                    fontSize: 24,
                  ),
                ),
                CupertinoSwitch(
                  activeColor: Colors.yellow[600],
                  //trackColor: const Color(0xFF292B3F),
                  thumbColor: const Color(0xFF1F2131),
                  onChanged: (bool value) {
                    setState(() {
                      isSilent = value;
                    });
                  },
                  value: isSilent,
                ),
              ],
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      CupertinoIcons.clear,
                      color: Colors.white,
                      size: 40,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 45,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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

  String getTimeString() {
    String hour = dateTime.hour.toString().padLeft(2, '0');
    String minute = dateTime.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }
}

class Clock0 extends CustomPainter {
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
        ..strokeWidth = 10
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
    for (double i = 0; i < 360; i += 10) {
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
          ..strokeWidth = 2,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Clock1 extends CustomPainter {
  @override
  void paint(ui.Canvas canvas, ui.Size size) {
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
