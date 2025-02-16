import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class RealTimeDate extends StatefulWidget {
  const RealTimeDate({super.key});

  @override
  State<RealTimeDate> createState() => _RealTimeDateState();
}

class _RealTimeDateState extends State<RealTimeDate> {
  late DateTime _now;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {
        _now = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      DateFormat('EEEE, d MMM').format(_now),
      style: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 14,
      ),
    );
  }
} 