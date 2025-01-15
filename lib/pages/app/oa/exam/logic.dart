import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swust_link/spider/exam_table.dart';

import '../../../../common/routes/app_pages.dart';
import 'state.dart';

class ExamLogic extends GetxController {
  final ExamState state = ExamState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getExams();
  }

  Future<void> getExams() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? username = prefs.getString('0username');
    final String? password = prefs.getString('0password');
    if (username != null && password != null) {
      state.examTable = ExamTable(username, password);
      state.exams.value = await state.examTable.getExams();
    } else {
      Get.dialog(AlertDialog(
        title: Text("暂未登录"),
        content: Text("您还未登录过一站式大厅，请先登录并保存信息! "),
        actions: [
          TextButton(
            onPressed: () {
              Get.toNamed(AppRoutes.MAIN + AppRoutes.ACCOUNT);
            },
            child: Text("确定"),
          ),
        ],
      ));
    }
  }
}
