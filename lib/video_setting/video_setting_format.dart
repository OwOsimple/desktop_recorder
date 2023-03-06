import 'package:desktop_recorder/video_setting/video_setting.dart';
import 'package:desktop_recorder/video_setting/video_setting_controller.dart';
import 'package:flutter/material.dart';

class VideoSettingFormat extends VideoSetting {
  @override
  Widget settingWidget() {
    return dropdownButton<String>(
      rxValue: VideoSettingController.of.format,
      items: [
        for (String format in VideoSettingController.availableFormats)
          DropdownMenuItem(
            value: format.toLowerCase(),
            child: Text(
              format.toUpperCase(),
              style: textStyle,
            ),
          ),
      ],
    );
  }

  @override
  String text() => 'Format:';
}
