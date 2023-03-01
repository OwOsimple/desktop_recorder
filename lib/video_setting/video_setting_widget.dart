import 'package:desktop_recorder/video_setting/video_setting.dart';
import 'package:desktop_recorder/video_setting/video_setting_directory.dart';
import 'package:desktop_recorder/video_setting/video_setting_format.dart';
import 'package:desktop_recorder/video_setting/video_setting_frame_rate.dart';
import 'package:desktop_recorder/video_setting/video_setting_resolution.dart';
import 'package:flutter/cupertino.dart';

class VideoSettingWidget extends StatelessWidget {
  final List<VideoSetting> videoSettings = [
    VideoSettingDirectory(),
    VideoSettingFormat(),
    VideoSettingResolution(),
    VideoSettingFrameRate(),
  ];

  VideoSettingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [for (int i = 0; i < videoSettings.length; i++) videoSettings[i].widget()],
    );
  }
}
