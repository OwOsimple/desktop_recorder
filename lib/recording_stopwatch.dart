import 'dart:async';
import 'dart:core';

import 'package:get/get.dart';

class RecordingStopwatch extends Object {
  final Stopwatch _stopwatch = Stopwatch();
  final Duration _tickDuration = const Duration(milliseconds: 100);
  final Rx<Duration> _elapsed = Duration.zero.obs;
  late Timer _timer;

  Rx<Duration> get elapsed => _elapsed;

  void _tick(_) => elapsed.value = _stopwatch.elapsed;

  void stop() {
    _timer.cancel();
    _stopwatch.stop();
    _stopwatch.reset();
    elapsed.value = Duration.zero;
  }

  void start() {
    _stopwatch.start();
    _timer = Timer.periodic(_tickDuration, _tick);
  }
}
