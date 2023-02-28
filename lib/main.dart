import 'dart:io';

import 'package:desktop_recorder/recording_behavior/windows_recording_behavior.dart';
import 'package:desktop_recorder/record_button.dart';
import 'package:desktop_recorder/record_controller.dart';
import 'package:desktop_recorder/recording_time_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  const String idleWindowTitle = 'Screen Recorder';
  const String recordingWindowTitle = 'Screen Recorder ... Recording';

  setWindowTitle(idleWindowTitle);
  setWindowMinSize(const Size(360, 480));

  if (Platform.isWindows) {
    Get.put(RecordController(behavior: WindowsRecordingBehavior()));
  }

  RecordController.recordingRegistry.listen((isRecording) {
    if (isRecording) {
      setWindowTitle(recordingWindowTitle);
    } else {
      setWindowTitle(idleWindowTitle);
    }
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget with WindowListener {
  MyApp({super.key}) {
    WindowManager.instance.addListener(this);
  }

  @override
  void onWindowClose() async {
    if (RecordController.isRecording) {
      await RecordController.recordingStopped();
    }
    super.onWindowClose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: RecordButton(recordBehavior: WindowsRecordingBehavior()),
            ),
            RecordingTimeWidget(),
          ],
        ),
      ),
    );
  }
}
