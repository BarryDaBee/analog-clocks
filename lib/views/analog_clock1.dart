import 'dart:async';

import 'package:analog_clocks/widgets/clock1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                  Positioned(
                    left: 120,
                    top: 25,
                    child: Text(
                      '12',
                      style: GoogleFonts.josefinSans(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 30,
                    top: 120,
                    child: Text(
                      '3',
                      style: GoogleFonts.josefinSans(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 120,
                    bottom: 30,
                    child: Text(
                      '6',
                      style: GoogleFonts.josefinSans(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 30,
                    top: 120,
                    child: Text(
                      '9',
                      style: GoogleFonts.josefinSans(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 12,
                      ),
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
