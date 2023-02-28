import 'package:desktop_recorder/recording_behavior/recording_arg.dart';

abstract class RecordingBehavior {
  Future<void> startRecording(RecordingArg args);

  Future<void> stopRecording();
}
