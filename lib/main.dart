import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:desktop_recorder/record_button.dart';
import 'package:desktop_recorder/record_controller.dart';
import 'package:desktop_recorder/recording_behavior/mac_recording_behavior.dart';
import 'package:desktop_recorder/recording_behavior/windows_recording_behavior.dart';
import 'package:desktop_recorder/recording_time_widget.dart';
import 'package:desktop_recorder/video_setting/video_setting_controller.dart';
import 'package:desktop_recorder/video_setting/video_setting_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_window_close/flutter_window_close.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:window_size/window_size.dart';

Future<void> setDesktopPath() async {
  final Directory directory = await getApplicationDocumentsDirectory();

  List<String> pathList = directory.path.split('\\');
  pathList[pathList.length - 1] = 'Desktop';
  final String desktopPath = pathList.join('\\');

  Get.put(desktopPath, tag: 'desktopPath');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows) {
    await setDesktopPath();
  }

  if (Platform.isWindows) {
    Get.put(RecordController(behavior: WindowsRecordingBehavior()));
  } else if (Platform.isMacOS) {
    Get.put(RecordController(behavior: MacRecordingBehavior()));
  }
  Get.put(VideoSettingController());

  const String idleWindowTitle = 'Screen Recorder';
  const String recordingWindowTitle = 'Screen Recorder ... Recording';
  setWindowTitle(idleWindowTitle);
  RecordController.of.listener.listen((isRecording) {
    if (isRecording) {
      setWindowTitle(recordingWindowTitle);
    } else {
      setWindowTitle(idleWindowTitle);
    }
  });
  setWindowMinSize(const Size(360, 480));

  FlutterWindowClose.setWindowShouldCloseHandler(() async {
    if (!RecordController.isRecording) {
      return true;
    }
    await CoolAlert.show(
      context: Get.context!,
      type: CoolAlertType.warning,
      text: "Still recording!\nPlease stop the recording before closing the app.",
    );
    return false;
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget _column() {
    if (Platform.isWindows) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: RecordButton(),
          ),
          RecordingTimeWidget(),
        ],
      );
    }

    /// Platform.isMacOS
    return FutureBuilder(
        future: const MethodChannel('com.example/desktop_recorder').invokeMethod('canRecordScreen'),
        builder: (_, result) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: (result.hasData && result.data == true) ? const RecordButton() : const RecordButton(enabled: false),
              ),
              RecordingTimeWidget(),
              (result.hasData && result.data == true)
                  ? const SizedBox.shrink()
                  : Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        color: Colors.redAccent.withAlpha(200),
                      ),
                      clipBehavior: Clip.hardEdge,
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(8.0),
                      child: const Text('Screen Recording Not Allowed'),
                    ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            VideoSettingWidget(),
            const Spacer(),
            _column(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
