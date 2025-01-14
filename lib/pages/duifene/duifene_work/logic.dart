import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swust_link/common/routes/app_pages.dart';

import 'state.dart';

class DuifeneWorkLogic extends GetxController {
  final DuifeneWorkState state = DuifeneWorkState();

  Future<void> loadDuifene() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? username = prefs.getString('1username');
    final String? password = prefs.getString('1password');

    if (username != null && password != null) {
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
}
