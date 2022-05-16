import 'package:flutter/material.dart';
import 'package:timely/modules/clock/widgets/clock_face_painter.dart';
import 'package:timely/shared/extensions.dart';

class ClockFace extends StatelessWidget {
  final DateTime dateTime;
  final bool isAhead;
  const ClockFace({Key? key, required this.dateTime, required this.isAhead}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      ),
      child: CustomPaint(
        painter: ClockFacePainter(
          time: dateTime,
          color: isAhead
              ? context.theme.backgroundColor.withOpacity(0.2)
              : context.textTheme.titleLarge!.color!,
          foregroundColor: isAhead
              ? context.theme.textTheme.bodyLarge!.color!
              : context.theme.scaffoldBackgroundColor,
        ),
      ),
    );
  }
}
