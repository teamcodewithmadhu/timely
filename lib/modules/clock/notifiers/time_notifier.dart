import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/clock/notifiers/clock_notifier.dart';

class TimeNotifier extends StateNotifier<DateTime> {
  late Timer _timer;

  final StreamController<DateTime> _streamController = StreamController.broadcast();

  Stream<DateTime> get dateStream => _streamController.stream;

  fromDateTime(DateTime dateTime) {
    return DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
      dateTime.minute,
      dateTime.second,
    );
  }

  TimeNotifier(TimeZone timeZone) : super(DateTime.now().toUtc().add(timeZone.offset)) {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // state = fromDateTime(state.add(const Duration(seconds: 1)));
      state = DateTime.now().toUtc().add(timeZone.offset);
    });
  }

  increment(Duration duration) {
    state = state.add(duration);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
