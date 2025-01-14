import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swust_link/common/routes/app_pages.dart';
import 'package:swust_link/spider/duifene.dart';

import 'state.dart';

class DuifeneCourseLogic extends GetxController {
  final DuifeneCourseState state = DuifeneCourseState();

  @override
  void onInit() {
    super.onInit();
    loadDuifene();
  }

  Future<void> loadDuifene() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? username = prefs.getString('1username');
    final String? password = prefs.getString('1password');
    if (username != null && password != null) {
      state.duifeneClient = DuiFenE(username: username, password: password);
      if (await state.duifeneClient.passwordLogin()) {
        state.courses.value = (await state.duifeneClient.getCourseInfo())!;
      } else {
        Get.dialog(AlertDialog(
          title: Text("登录对分易错误"),
          content: Text("请检查账号密码是否无误并修改保存! "),
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
    } else {
      Get.dialog(AlertDialog(
        title: Text("暂未登录"),
        content: Text("您还未登录过对分易，请先登录并保存信息! "),
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



  Future<void> joinClass() async {
    Get.dialog(
      AlertDialog(
        title: Text("加入班级"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "班级码(5位字母)",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: state.classIdController.value,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Get.back();
              String? msg = await state.duifeneClient.joinClass(state.classIdController.value.text);
              Get.snackbar("", msg!);
            },
            child: Text("确定"),
          ),
        ],
      ),
    );
  }
}
