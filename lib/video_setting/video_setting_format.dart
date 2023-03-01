import 'package:desktop_recorder/video_setting/video_setting.dart';
import 'package:flutter/material.dart';

class VideoSettingFormat extends VideoSetting {
  @override
  Widget settingWidget() {
    return DropdownButton(
      isExpanded: true,
      value: 'mp4',
      items: <DropdownMenuItem<String>>[
        DropdownMenuItem(
          value: 'mp4',
          child: Text(
            'MP4',
            style: textStyle,
          ),
        ),
      ],
      onChanged: (String? value) {},
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      underline: const SizedBox(),
    );
  }

  @override
  Widget textWidget() {
    return Text(
      'Format:',
      style: textStyle,
    );
  }
}
