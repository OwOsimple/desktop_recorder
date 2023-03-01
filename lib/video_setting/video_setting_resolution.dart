import 'package:desktop_recorder/video_setting/video_setting.dart';
import 'package:flutter/material.dart';

class VideoSettingResolution extends VideoSetting {
  @override
  Widget settingWidget() {
    return DropdownButton<Size>(
      isExpanded: true,
      value: const Size(360, 240),
      items: <DropdownMenuItem<Size>>[
        DropdownMenuItem(
          value: const Size(360, 240),
          child: Text(
            '360x240',
            style: textStyle,
          ),
        ),
      ],
      onChanged: (Size? value) {},
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      underline: const SizedBox(),
    );
  }

  @override
  Widget textWidget() {
    return Text(
      'Resolution:',
      style: textStyle,
    );
  }
}
