import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/clock/notifiers/clock_notifier.dart';
import 'package:timely/modules/clock/notifiers/time_notifier.dart';
import 'package:timely/modules/clock/notifiers/timezone_list_notifier.dart';
import 'package:timezone/timezone.dart' as timezone;

final clockStateProvider = StateNotifierProvider.autoDispose<ClockNotifier, ClockState>((ref) {
  ref.maintainState = true;
  return ClockNotifier();
});

final timeStateProvider = StateNotifierProvider.autoDispose<TimeNotifier, DateTime>((ref) {
  final ClockState state = ref.watch(clockStateProvider);

  return TimeNotifier(state.currentTimezone);
});

final timezoneListProvider = StateNotifierProvider<TimezoneListNotifier, List<timezone.Location>>(
    (ref) => TimezoneListNotifier());
