import 'package:desktop_recorder/record_controller.dart';
import 'package:desktop_recorder/recording_stopwatch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecordingTimeWidget extends StatelessWidget {
  final RecordingStopwatch stopwatch = RecordingStopwatch();
  final Rx<Duration> elapsed = Duration.zero.obs;

  RecordingTimeWidget({super.key}) {
    stopwatch.elapsed.listen(
      (elapsedDuration) => elapsed.value = elapsedDuration,
    );
    RecordController.of.listener.listen(
      (isRecording) => isRecording ? stopwatch.start() : stopwatch.stop(),
    );
  }

  String _customFormat(Duration duration) {
    String twoDigits(int number) => number.toString().padLeft(2, '0');

    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    String milliseconds = duration.inMilliseconds.remainder(1000).toString().padLeft(3, '0').substring(0, 1);

    return "$hours:$minutes:$seconds.$milliseconds";
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final Color iconColor = RecordController.isRecording ? Colors.red : Colors.black45;

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.circle_rounded,
              color: iconColor,
              size: 12,
            ),
          ),
          Text(
            _customFormat(elapsed.value).toString(),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              height: 1.1,
            ),
          ),
        ],
      );
    });
  }
}
