import 'package:flutter/material.dart';

class RecordingArg {
  final Size resolution;
  final String fileName;
  final String fileExtension;
  final int frameRate;

  RecordingArg({
    required this.resolution,
    required this.fileName,
    required this.fileExtension,
    required this.frameRate,
  });
}
