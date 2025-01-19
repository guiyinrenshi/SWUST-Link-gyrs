import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swust_link/common/global.dart';

import 'state.dart';

class DuifeneSignLogic extends GetxController {
  final DuifeneSignState state = DuifeneSignState();

  Future<void> submitSignCode() async {
    String msg =
        await Global.duiFenE?.signIn(state.textController.text) ?? "登录对分易失败";
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
  }
}
