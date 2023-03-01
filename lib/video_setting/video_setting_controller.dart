import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoSettingController extends GetxController {
  static VideoSettingController get of => Get.find();

  String _directory = Platform.isWindows ? Get.find(tag: 'desktopPath') : Directory.current.path;
  String _format = 'mp4';
  Size _size = const Size(360, 240);
  int _frameRate = 30;

  String get directory => _directory;

  String get format => _format;

  Size get size => _size;

  int get frameRate => _frameRate;

  void setSetting({String? directory, String? format, Size? size, int? frameRate}) {
    if (directory != null) {
      _directory = directory;
    }
    if (format != null) {
      _format = format;
    }
    if (size != null) {
      _size = size;
    }
    if (frameRate != null) {
      _frameRate = frameRate;
    }
  }
}
