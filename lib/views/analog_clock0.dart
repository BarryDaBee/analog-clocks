import 'dart:async';

import 'package:analog_clocks/widgets/clock0.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
              child: SizedBox(
                height: 240,
                width: 240,
                child: CustomPaint(
                  painter: Clock0(),
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
