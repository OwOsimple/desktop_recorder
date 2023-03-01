import 'dart:io';

import 'package:desktop_recorder/recording_behavior/recording_arg.dart';
import 'package:desktop_recorder/recording_behavior/recording_behavior.dart';
import 'package:process_run/shell.dart';

class WindowsRecordingBehavior extends RecordingBehavior {
  Process? _process;

  @override
  Future<void> startRecording(RecordingArg args) async {
    final String resolution = '${args.resolution.width}:${args.resolution.height}';
    final String resolutionSetting =
        '-vf "scale=$resolution:force_original_aspect_ratio=decrease,pad=$resolution:-1:-1:color=black"';
    Shell().run(
      'assets/ffmpeg.exe -f gdigrab -framerate ${args.frameRate} -i desktop $resolutionSetting "${args.fileName}.${args.fileExtension}"',
      onProcess: (process) => _process = process,
    );
  }

  @override
  Future<void> stopRecording() async {
    _process?.stdin.write('q');
    _process = null;
  }
}
