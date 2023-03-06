import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoSettingController extends GetxController {
  static VideoSettingController get of => Get.find();

  final RxString directory = '${Platform.isWindows ? Get.find(tag: 'desktopPath') : Directory.current.path}'.obs;
  final RxString format = availableFormats.first.obs;
  final Rx<Size> size = availableResolutions.first.obs;
  final RxInt frameRate = availableFrameRates.first.obs;

  /// Modify video format(s) in the list
  static final List<String> availableFormats = [
    'mp4',
  ];

  /// Modify resolution(s) in the list
  static final List<Size> availableResolutions = [
    const Size(360, 240),
  ];

  /// Modify framerate(s) in the list
  static final List<int> availableFrameRates = [
    30,
  ];
}
