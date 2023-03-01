import 'package:desktop_recorder/video_setting/video_setting.dart';
import 'package:desktop_recorder/video_setting/video_setting_controller.dart';
import 'package:flutter/material.dart';

class VideoSettingFrameRate extends VideoSetting {
  @override
  Widget settingWidget() {
    return DropdownButton(
      isExpanded: true,
      value: VideoSettingController.of.frameRate,
      items: <DropdownMenuItem<int>>[
        DropdownMenuItem(
          value: 30,
          child: Text(
            '30',
            style: textStyle,
          ),
        ),
      ],
      onChanged: (int? value) {
        VideoSettingController.of.setSetting(frameRate: value);
      },
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      underline: const SizedBox(),
    );
  }

  @override
  Widget textWidget() {
    return Text(
      'Frame Rate:',
      style: textStyle,
    );
  }
}
