import 'package:desktop_recorder/video_setting/video_setting.dart';
import 'package:desktop_recorder/video_setting/video_setting_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class VideoSettingDirectory extends VideoSetting {
  TextEditingController controller = TextEditingController(text: VideoSettingController.of.directory);

  @override
  Widget settingWidget() {
    return TextField(
      readOnly: true,
      controller: controller,
      style: textStyle,
      strutStyle: StrutStyle.disabled,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.only(top: 10),
        border: InputBorder.none,
        suffixIcon: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.hardEdge,
          child: IconButton(
            icon: const Icon(
              Icons.folder_open_rounded,
              color: Colors.grey,
            ),
            onPressed: () async {
              final String? directory = await FilePicker.platform.getDirectoryPath(initialDirectory: controller.text);
              if (directory != null) {
                VideoSettingController.of.setSetting(directory: directory);
                controller.text = directory;
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget textWidget() {
    return Text(
      'Directory:',
      style: textStyle,
    );
  }
}
