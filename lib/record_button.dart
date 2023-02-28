import 'package:desktop_recorder/recording_behavior/recording_behavior.dart';
import 'package:desktop_recorder/record_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecordButton extends StatelessWidget {
  final RecordingBehavior recordBehavior;

  const RecordButton({
    super.key,
    required this.recordBehavior,
  });

  void _onPressed() async {
    if (RecordController.isRecording) {
      await RecordController.recordingStopped();
    } else {
      await RecordController.recordingStarted();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Widget icon = Obx(() {
      final IconData iconData = RecordController.isRecording ? Icons.square_rounded : Icons.circle_rounded;
      return Icon(iconData, color: Colors.black45);
    });

    final Widget iconButton = IconButton(
      onPressed: _onPressed,
      icon: icon,
    );

    return SizedBox(
      width: 72,
      height: 72,
      child: Material(
        color: Colors.redAccent,
        shape: const CircleBorder(),
        child: iconButton,
      ),
    );
  }
}
