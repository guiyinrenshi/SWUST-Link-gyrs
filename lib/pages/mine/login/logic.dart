import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swust_link/common/entity/account.dart';
import 'package:swust_link/common/global.dart';
import 'package:swust_link/common/routes/app_pages.dart';
import 'package:swust_link/spider/duifene.dart';
import 'package:swust_link/spider/matrix_oa.dart';
import 'package:swust_link/spider/sjjx_class_table.dart';
import 'package:swust_link/spider/xsc_oa.dart';

import 'state.dart';

class LoginLogic extends GetxController {
  final LoginState state = LoginState();

  LoginLogic();

  @override
  Future<void> onInit() async {
    super.onInit();
    initDropDownItem();
    await loadUseInfo();
  }

  void initDropDownItem() {
    for (var i in Platform.values) {
      state.dropDownItem.add(DropdownMenuEntry(value: i.code, label: i.des));
    }
  }

  void changeShowPassword() {
    state.isShowPassword.value = !state.isShowPassword.value;
  }

  Future<void> testLogin() async {


    state.account = Account(state.username.value, state.password.value,
        state.currentPlatform.value);
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      barrierDismissible: false, // 禁止点击外部关闭
    );
    var res = await state.account.testLogin();
    Get.back();
    Get.dialog(
      AlertDialog(
        title: Text(res['key'] ? "登录成功" : "登录失败"),
        content: Text(res['key'] ? "测试登录成功!保存信息后即代表您同意了隐私与协议!" : res['message']),

        actions: [
          res['key']
              ? TextButton(
                  onPressed: () {
                    Get.toNamed(
                        AppRoutes.MAIN + AppRoutes.PRIVACY_AND_PROTOCOL);
                  },
                  child: Text("隐私与协议"))
              : TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text("取消")),
          res['key']
              ? TextButton(
                  onPressed: () {
                    Get.back();
                    saveUseInfo();
                  },
                  child: Text("保存信息"),
                )
              : TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text("确定")),
        ],
      ),
    );
  }

  Future<void> loadUseInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? username =
        prefs.getString('${state.currentPlatform}username');
    final String? password =
        prefs.getString('${state.currentPlatform}password');

    if (username != null && password != null) {
      state.usernameController.value.text = username;
      state.passwordController.value.text = password;
      state.username.value = username;
      state.password.value = password;
    }
  }

  Future<void> saveUseInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        '${state.account.platformCode}username', state.account.username);
    await prefs.setString(
        '${state.account.platformCode}password', state.account.password);
    if (state.account.platformCode == 0) {
      XSCOA.xscoa = null;
      MatrixOa.matrixOa = null;
      SJJXTable.sjjxTable = null;
    } else if (state.account.platformCode == 1) {
      DuiFenE.duiFenE = null;
    }
    Get.dialog(AlertDialog(
      title: Text("保存成功"),
      content: Text("保存${state.username.value}登录信息成功, 后续无需再次登录!"),
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
