import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swust_link/spider/duifene.dart';

import '../../common/routes/app_pages.dart';
import 'state.dart';

class DuifeneSignLogic extends GetxController {
  final DuifeneSignState state = DuifeneSignState();

  Future<void> submitSignCode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? username = prefs.getString('1username');
    final String? password = prefs.getString('1password');
    if (username != null && password != null) {
      state.duifeneClient = DuiFenE(username: username, password: password);
      if (await state.duifeneClient.passwordLogin()) {
        String msg =
            await state.duifeneClient.signIn(state.textController.text);
        Get.dialog(AlertDialog(
          title: Text("签到结果"),
          content: Text(msg),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("确定"),
            ),
          ],
        ));
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
}
