import 'package:desktop_recorder/record_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecordButton extends StatelessWidget {
  final bool enabled;

  const RecordButton({
    super.key,
    this.enabled = true,
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

    Widget iconButton = IconButton(
      onPressed: enabled ? _onPressed : null,
      icon: icon,
    );

    return SizedBox(
      width: 72,
      height: 72,
      child: Material(
        color: enabled ? Colors.redAccent : Colors.grey,
        shape: const CircleBorder(),
        child: iconButton,
      ),
    );
  }
}
