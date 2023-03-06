import 'package:desktop_recorder/recording_behavior/recording_arg.dart';
import 'package:desktop_recorder/recording_behavior/recording_behavior.dart';
import 'package:desktop_recorder/video_setting/video_setting_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RecordController extends GetxController {
  final RxBool _isRecording = false.obs;
  final RecordingBehavior behavior;

  RecordController({required this.behavior});

  static RecordController get of => Get.find();

  static bool get isRecording => RecordController.of._isRecording.value;

  Future<void> recordingStopped() async {
    await RecordController.of.behavior.stopRecording();
    RecordController.of._isRecording.value = false;
  }

  Future<void> recordingStarted() async {
    final String fileName = DateFormat('yyyy-MM-dd HH.mm.ss').format(DateTime.now());
    await RecordController.of.behavior.startRecording(
      RecordingArg(
        resolution: VideoSettingController.of.size.value,
        fileName: '${VideoSettingController.of.directory.value}/$fileName',
        fileExtension: VideoSettingController.of.format.value,
        frameRate: VideoSettingController.of.frameRate.value,
      ),
    );
    RecordController.of._isRecording.value = true;
  }

  RxBool get listener => _isRecording;
}
