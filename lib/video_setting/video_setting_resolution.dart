import 'package:desktop_recorder/video_setting/video_setting.dart';
import 'package:desktop_recorder/video_setting/video_setting_controller.dart';
import 'package:flutter/material.dart';

class VideoSettingResolution extends VideoSetting {
  @override
  Widget settingWidget() {
    return dropdownButton<Size>(
      rxValue: VideoSettingController.of.size,
      items: [
        for (Size size in VideoSettingController.availableResolutions)
          DropdownMenuItem(
            value: size,
            child: Text(
              '${size.width.toInt()}x${size.height.toInt()}',
              style: textStyle,
            ),
          ),
      ],
    );
  }

  @override
  String text() => 'Resolution:';
}
