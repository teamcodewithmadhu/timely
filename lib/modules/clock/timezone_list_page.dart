import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/clock/notifiers/clock_notifier.dart';
import 'package:timely/modules/clock/providers.dart';
import 'package:timezone/timezone.dart' as tz;

class TimezoneListPage extends ConsumerWidget {
  const TimezoneListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final List<tz.Location> timezones = ref.watch(timezoneListProvider);

    ref.listen<List<tz.Location>>(timezoneListProvider, (p, n) {});

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select City"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(0),
        itemCount: timezones.length,
        itemBuilder: (ctx, index) {
          final timezone = timezones[index];

          final duration = Duration(milliseconds: timezone.currentTimeZone.offset);

          return ListTile(
            title: Text(timezone.name.split('/').last),
            subtitle: Text(
                "${timezone.name.split('/').first} GMT${duration.inHours >= 0 ? '+' : ''}${duration.inHours.toString()}:${(duration.inMinutes % 60).toString()}"),
            onTap: () {
              // FIXME: only add if the timezone is not already in the list
              final _timezone = TimeZone(
                name: timezone.name,
                offset: duration,
              );

              ref.read(clockStateProvider.notifier).addTimezone(_timezone);

              Navigator.of(context).pop();
            },
          );
        },
      ),
    );
  }
}
