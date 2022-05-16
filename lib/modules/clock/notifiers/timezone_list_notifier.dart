import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/timezone.dart' as timezone;

int sortList(a, b) => a.name.split('/').last.compareTo(b.name.split('/').last);

class TimezoneListNotifier extends StateNotifier<List<timezone.Location>> {
  TimezoneListNotifier()
      : super(timezone.timeZoneDatabase.locations.values.toList()..sort(sortList));
}
