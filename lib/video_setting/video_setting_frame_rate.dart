import 'package:desktop_recorder/video_setting/video_setting.dart';
import 'package:desktop_recorder/video_setting/video_setting_controller.dart';
import 'package:flutter/material.dart';

class VideoSettingFrameRate extends VideoSetting {
  @override
  Widget settingWidget() {
    return dropdownButton<int>(
      rxValue: VideoSettingController.of.frameRate,
      items: [
        for (int frameRate in VideoSettingController.availableFrameRates)
          DropdownMenuItem(
            value: frameRate,
            child: Text(
              frameRate.toString(),
              style: textStyle,
            ),
          ),
      ],
    );
  }

  @override
  String text() => 'Frame Rate:';
}
