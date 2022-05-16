import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timely/modules/clock/providers.dart';
import 'package:timely/shared/extensions.dart';

/// Take the UTC time and add the timeoffset
///
class DigitalClock extends ConsumerWidget {
  const DigitalClock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final date = ref.watch(timeStateProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          DateFormat('hh:mm:ss').format(date),
          style: const TextStyle(fontSize: 45),
        ),
        Text(
          "Current: ${DateFormat('dd/MM/yyy a').format(date)}",
          style: TextStyle(color: context.theme.hintColor),
        ),
      ],
    );
  }
}
