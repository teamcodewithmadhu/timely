import 'package:flutter/material.dart';
import 'package:timely/timely.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();

  runApp(const Timely());
}
