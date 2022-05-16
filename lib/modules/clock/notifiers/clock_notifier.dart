import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimeZone {
  final String name;
  final Duration offset;

  TimeZone({required this.name, required this.offset});
}

class ClockState {
  final TimeZone currentTimezone;
  final List<TimeZone> timezones;

  ClockState({required this.currentTimezone, required this.timezones});

  factory ClockState.initial() {
    final now = DateTime.now().toLocal();

    return ClockState(
      currentTimezone: TimeZone(
        name: now.timeZoneName,
        offset: now.timeZoneOffset,
      ),
      timezones: [],
    );
  }
}

class ClockNotifier extends StateNotifier<ClockState> {
  ClockNotifier() : super(ClockState.initial());

  addTimezone(TimeZone timezone) {
    state = ClockState(
      currentTimezone: state.currentTimezone,
      timezones: [...state.timezones, timezone],
    );
  }

  setCurrentTimezone(TimeZone timezone) {
    state = ClockState(
      currentTimezone: timezone,
      timezones: state.timezones,
    );
  }
}
