import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/clock/notifiers/clock_notifier.dart';
import 'package:timely/modules/clock/providers.dart';
import 'package:timely/modules/clock/timezone_list_page.dart';
import 'package:timely/modules/clock/widgets/clock_tile.dart';
import 'package:timely/modules/clock/widgets/digital_clock.dart';
import 'package:timely/shared/extensions.dart';

class ClockPage extends ConsumerWidget {
  const ClockPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final List<TimeZone> timezones =
        ref.watch(clockStateProvider.select((value) => value.timezones));

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(28).copyWith(bottom: 36),
            child: const DigitalClock(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: timezones.length,
              itemBuilder: (ctx, index) {
                final timezone = timezones[index];

                return ClockTile(timezone: timezone);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (ctx) => const TimezoneListPage()));
        },
        child: const Icon(
          Icons.add,
          size: 36,
        ),
        // backgroundColor: Colors.white,
        // foregroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
