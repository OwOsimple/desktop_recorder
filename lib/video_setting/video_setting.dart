import 'package:desktop_recorder/record_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class VideoSetting {
  final RxBool enabled = true.obs;

  VideoSetting() {
    RecordController.recordingRegistry.listen((isRecording) {
      enabled.value = !isRecording;
    });
  }

  Widget widget() {
    return Container(
      width: 400,
      height: 58,
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 95,
                child: textWidget(),
              ),
              Container(
                width: 225,
                height: 42,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: settingWidget(),
              ),
            ],
          ),
          Obx(
            () => !enabled.value ? Container(color: Colors.transparent) : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  TextStyle get textStyle => const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold);

  Widget settingWidget();

  Widget textWidget();
}
