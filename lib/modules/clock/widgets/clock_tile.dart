import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timely/modules/clock/notifiers/clock_notifier.dart';
import 'package:timely/modules/clock/providers.dart';
import 'package:timely/modules/clock/widgets/clock_face.dart';
import 'package:timely/shared/extensions.dart';

// local provider to filterout state for clock tile widget
final tileStreamProvider = StreamProvider.autoDispose<DateTime>((ref) {
  final StreamController<DateTime> _streamController = StreamController();

  _streamController.add(ref.read(timeStateProvider));

  ref.listen<DateTime>(timeStateProvider, (o, n) {
    if (o?.minute != n.minute) {
      _streamController.add(n);
    }
  });

  ref.onDispose(() {
    _streamController.close();
  });

  return _streamController.stream;
});

class ClockTile extends ConsumerWidget {
  final TimeZone timezone;

  const ClockTile({Key? key, required this.timezone}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final ClockState state = ref.watch(clockStateProvider);

    final dateStream = ref.watch(tileStreamProvider);

    final isAhead = timezone.offset.compareTo(state.currentTimezone.offset) > 0;

    final differenceMinutes = timezone.offset.inMinutes - state.currentTimezone.offset.inMinutes;

    final duration = Duration(minutes: differenceMinutes.abs());

    return dateStream.when(
      data: (value) {
        final date = value.add(timezone.offset - state.currentTimezone.offset);

        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 28, vertical: 4),
          leading: ClockFace(dateTime: date, isAhead: isAhead),
          title: Text(
            timezone.name.split("/").last,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "${duration.inHours} hrs ${duration.inMinutes % 60} mins ${isAhead ? "ahead" : "behind"}",
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat('hh:mm').format(date),
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                DateFormat('dd MMM a').format(date),
                style: TextStyle(color: context.textTheme.caption!.color),
              ),
            ],
          ),
          onTap: () {},
        );
      },
      error: (s, e) => const Text("Error"),
      loading: () => const Text("loading"),
    )!;
  }
}
