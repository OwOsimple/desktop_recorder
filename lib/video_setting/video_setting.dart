import 'package:desktop_recorder/record_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class VideoSetting {
  final RxBool enabled = true.obs;

  VideoSetting() {
    RecordController.of.listener.listen((isRecording) {
      enabled.value = !isRecording;
    });
  }

  Widget settingWidget();

  String text();

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
                child: Text(text(), style: textStyle),
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

  Widget dropdownButton<T>({
    required Rx<T> rxValue,
    required List<DropdownMenuItem<T>> items,
  }) {
    return Obx(
      () => DropdownButton<T>(
        isExpanded: true,
        value: rxValue.value,
        items: items,
        onChanged: (T? t) {
          rxValue.value = t as T;
        },
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 24,
        underline: const SizedBox(),
      ),
    );
  }

  TextStyle get textStyle => const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold);
}
