import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swust_link/components/acg_background/view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart'; // 用于复制文件到本地

import '../../../common/global.dart';
import 'logic.dart';
import 'state.dart';
import 'package:intl/intl.dart';

class Params_settingPage extends StatelessWidget {
  Params_settingPage({Key? key}) : super(key: key);

  final Params_settingLogic logic = Get.put(Params_settingLogic());
  final Params_settingState state = Get.find<Params_settingLogic>().state;



  @override
  Widget build(BuildContext context) {
    return AcgBackgroundComponent(
      title: Text("参数设置"),
      actions: [
        TextButton(
          onPressed: () {
            // 保存逻辑
            final firstDay = state.firstDayController.text;
            final autoQueryTime = state.autoQueryTimeController.text;
            final isAutoQuery = state.isAutoQueryEnabled.value;
            final isAnime = state.isAnime.value;
            final isUploadBg = state.isUploadBg.value;
            logic.saveSettings(firstDay, autoQueryTime, isAutoQuery, isAnime, isUploadBg);
            Get.snackbar(
              "保存成功",
              "参数设置已保存",
              snackPosition: SnackPosition.BOTTOM,
            );
          },
          child: Row(
            children: [Icon(Icons.save), Text("保存")],
          ),
        ),
      ],
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 本学期第一天
              TextFormField(
                controller: state.firstDayController,
                decoration: InputDecoration(
                  labelText: "本学期第一天",
                  hintText: "选择日期",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        final formattedDate = DateFormat('yyyy-MM-dd')
                            .format(pickedDate); // 格式化日期

                        state.firstDayController.text = formattedDate;
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // 自动查询作业功能是否开启
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "是否开启自动查询作业功能",
                    style: TextStyle(fontSize: 16),
                  ),
                  Obx(
                        () => Switch(
                      value: state.isAutoQueryEnabled.value,
                      onChanged: (value) {
                        state.isAutoQueryEnabled.value = value;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // 自动查询时间
              TextFormField(
                controller: state.autoQueryTimeController,
                decoration: InputDecoration(
                  labelText: "自动查询时间",
                  hintText: "每天的时间点 (HH:mm)",
                  border: OutlineInputBorder(),
                  suffixIcon: const Icon(Icons.access_time),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "动漫模式",
                    style: TextStyle(fontSize: 16),
                  ),
                  Obx(
                        () => Switch(
                      value: state.isAnime.value,

                      onChanged: (value) {
                        if (value) {
                          state.isUploadBg.value = false;  // 关闭上传背景
                        }
                        state.isAnime.value = value;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "自定义上传背景",
                    style: TextStyle(fontSize: 16),
                  ),
                  Obx(
                        () => Switch(
                      value: state.isUploadBg.value,
                      onChanged: (value) {
                        if (value) {
                          state.isAnime.value = false;  // 关闭上传背景
                          logic.checkImageSave();
                        }
                        state.isUploadBg.value = value;
                      },
                    ),
                  ),
                ],
              ),
              // 文件上传按钮
              ElevatedButton(
                onPressed: logic.pickAndSaveFile,
                child: Row(
                  children: [Icon(Icons.upload_file), Text("上传背景图片")],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "清除图片缓存",
                    style: TextStyle(fontSize: 16),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      logic.clearImage();
                      Get.snackbar(
                        "操作成功",
                        "删除图片缓存",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                    icon: const Icon(Icons.delete),
                    label: const Text("删除"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
