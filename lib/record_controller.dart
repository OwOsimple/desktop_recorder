import 'package:desktop_recorder/recording_behavior/recording_arg.dart';
import 'package:desktop_recorder/recording_behavior/recording_behavior.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RecordController extends GetxController {
  final RxBool _isRecording = false.obs;
  final RecordingBehavior behavior;

  RecordController({required this.behavior});

  static RecordController get of => Get.find();

  static bool get isRecording => RecordController.of._isRecording.value;

  static Future<void> recordingStopped() async {
    await RecordController.of.behavior.stopRecording();
    RecordController.of._isRecording.value = false;
  }

  static Future<void> recordingStarted() async {
    /// get argument
    final String fileName = DateFormat('yyyy-MM-dd HH.mm.ss').format(DateTime.now());
    await RecordController.of.behavior.startRecording(
      RecordingArg(
        resolution: Size(360, 240),
        fileName: fileName,
        fileExtension: 'mp4',
        frameRate: 30,
      ),
    );
    RecordController.of._isRecording.value = true;
  }

  static RxBool get recordingRegistry => RecordController.of._isRecording;
}