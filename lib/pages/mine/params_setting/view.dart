import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';
import 'package:intl/intl.dart';

class Params_settingPage extends StatelessWidget {
  Params_settingPage({Key? key}) : super(key: key);

  final Params_settingLogic logic = Get.put(Params_settingLogic());
  final Params_settingState state = Get.find<Params_settingLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: [
          Expanded(
            child: Text("参数设置"),
          ),
          TextButton(
              onPressed: () {
                // 保存逻辑
                final firstDay = state.firstDayController.text;
                final autoQueryTime = state.autoQueryTimeController.text;
                final isEnabled = state.isAutoQueryEnabled.value;

                logic.saveSettings(firstDay, autoQueryTime, isEnabled);

                Get.snackbar(
                  "保存成功",
                  "参数设置已保存",
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              child: Row(
                children: [Icon(Icons.save), Text("保存")],
              ))
        ],
      )),
      body: Padding(
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
                      final formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // 格式化日期

                      state.firstDayController.text =
                          formattedDate;
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
              // initialValue: "12:30",
              controller: state.autoQueryTimeController,
              decoration: InputDecoration(
                labelText: "自动查询时间",
                hintText: "每天的时间点 (HH:mm)",
                border: OutlineInputBorder(),
                suffixIcon: const Icon(Icons.access_time),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
