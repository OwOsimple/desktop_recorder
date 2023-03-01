import 'dart:io';

import 'package:desktop_recorder/recording_behavior/recording_arg.dart';
import 'package:desktop_recorder/recording_behavior/recording_behavior.dart';
import 'package:process_run/shell.dart';

class WindowsRecordingBehavior extends RecordingBehavior {
  Process? _process;
  late String _ffmpegPath;

  WindowsRecordingBehavior() {
    List<String> pathList = Platform.resolvedExecutable.split('\\')
      ..removeLast()
      ..addAll(['data', 'flutter_assets', 'assets']);
    _ffmpegPath = pathList.join('\\');
  }

  @override
  Future<void> startRecording(RecordingArg args) async {
    final String resolution = '${args.resolution.width}:${args.resolution.height}';
    final String resolutionSetting =
        '-vf "scale=$resolution:force_original_aspect_ratio=decrease,pad=$resolution:-1:-1:color=black"';
    Shell().run(
      '$_ffmpegPath\\ffmpeg.exe -f gdigrab -framerate ${args.frameRate} -i desktop $resolutionSetting "${args.fileName}.${args.fileExtension}"',
      onProcess: (process) => _process = process,
    );
  }

  @override
  Future<void> stopRecording() async {
    _process?.stdin.write('q');
    _process = null;
  }
}
