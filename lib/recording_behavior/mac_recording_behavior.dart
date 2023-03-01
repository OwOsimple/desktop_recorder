import 'dart:async';

import 'package:desktop_recorder/recording_behavior/recording_arg.dart';
import 'package:desktop_recorder/recording_behavior/recording_behavior.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';

class MacRecordingBehavior extends RecordingBehavior {
  late String _screenIndex;

  MacRecordingBehavior() {
    final regex = RegExp(r'\[(\d+)\] Capture screen');
    FFmpegKit.executeAsync(
      '-f avfoundation -list_devices true -i " "',
      null,
      (log) {
        final RegExpMatch? match = regex.firstMatch(log.getMessage());
        if (match != null) {
          _screenIndex = match.group(1)!;
        }
      },
    );
  }

  @override
  Future<void> startRecording(RecordingArg args) async {
    final String resolution = '${args.resolution.width}:${args.resolution.height}';
    final String resolutionSetting = '-vf "scale=$resolution:force_original_aspect_ratio=decrease,pad=$resolution:-1:-1:color=black"';

    FFmpegKit.executeAsync(
      '-f avfoundation -framerate ${args.frameRate} -vsync 2 -i "$_screenIndex" $resolutionSetting "${args.fileName}.${args.fileExtension}"',
    );
  }

  @override
  Future<void> stopRecording() async {
    FFmpegKit.cancel();
  }
}
