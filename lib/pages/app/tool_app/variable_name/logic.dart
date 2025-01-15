import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:swust_link/common/routes/app_pages.dart';
import 'state.dart';

class VariableNameLogic extends GetxController {
  final VariableNameState state = VariableNameState();

  @override
  void onInit() {
    super.onInit();
    verifyInformation();
  }

  Future<void> verifyInformation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? appID = prefs.getString('2username');
    final String? key = prefs.getString('2password');
    if (appID == null || key == null) {
      Get.dialog(AlertDialog(
        title: Text("无已保存的密钥"),
        content: Text("您还未添加您的百度翻译开放平台开发者密钥，请先添加并保存信息!"),
        actions: [
          TextButton(
            onPressed: () {
              Get.toNamed(AppRoutes.MAIN + AppRoutes.ACCOUNT);
            },
            child: Text("确定"),
          ),
        ],
      ));
    } else {
    }
  }

  Future<void> getVariableName(String inputText) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? appID = prefs.getString('2username');
    final String? key = prefs.getString('2password');
    if (appID != null && key != null) {
      String salt = _generateSalt(10);
      String query = inputText;
      String sign = generateSign(appID, key, query, salt);
      String url = 'http://api.fanyi.baidu.com/api/trans/vip/translate'
          '?q=${Uri.encodeComponent(query)}'
          '&from=auto'
          '&to=en'
          '&appid=$appID'
          '&salt=$salt'
          '&sign=$sign';
      final response = await http.get(Uri.parse(url));
      String logInfo = "";
      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        if (!responseBody.containsKey("error_code")) {
          String result = responseBody["trans_result"][0]["dst"];
          state.variableName.value = result;
          state.variableNameAupper.value =
              result.replaceAll(RegExp(r'\s+'), '').toUpperCase();
          state.variableNameAlower.value =
              result.replaceAll(RegExp(r'\s+'), '').toLowerCase();
          state.variableNameUpperUnderline.value =
              result.replaceAll(RegExp(r'\s+'), '_').toUpperCase();
          state.variableNameLowerUnderline.value =
              result.replaceAll(RegExp(r'\s+'), '_').toLowerCase();
          state.variableNameSupper.value = result
              .split(' ')
              .map((word) =>
                  word[0].toUpperCase() + word.substring(1).toLowerCase())
              .join('');
          String temp = result
              .split(' ')
              .map((word) =>
                  word[0].toUpperCase() + word.substring(1).toLowerCase())
              .join('');
          state.variableNameSlower.value =
              temp[0].toLowerCase() + temp.substring(1);
          update();
        } else {
          if (responseBody["error_code"] == "52001") {
            logInfo = "请求超时，检查请求query是否超长，以及原文或译文参数是否支持";
          } else if (responseBody["error_code"] == "52002") {
            logInfo = "系统错误，请重试";
          } else if (responseBody["error_code"] == "52003") {
            logInfo = "未授权用户，请检查您的appID是否正确，或者服务是否开通";
          } else if (responseBody["error_code"] == "54000") {
            logInfo = "必填参数为空，请检查是否少传参数";
          } else if (responseBody["error_code"] == "54001") {
            logInfo = "签名错误，请检查您的签名生成方法";
          } else if (responseBody["error_code"] == "58000") {
            logInfo = "客户端IP非法，请检查个人资料里填写的IP地址是否正确，可前往开发者信息-基本信息修改";
          } else if (responseBody["error_code"] == "54003") {
            logInfo = "访问频率受限，请降低您的调用频率，或进行身份认证后切换为高级版";
          } else if (responseBody["error_code"] == "54004") {
            logInfo = "账户余额不足，请前往管理控制台为账户充值";
          } else if (responseBody["error_code"] == "54005") {
            logInfo = "长query请求频繁，请降低长query的发送频率，3s后再试";
          } else if (responseBody["error_code"] == "58001") {
            logInfo = "译文语言方向不支持，请检查译文语言是否在语言列表里";
          } else {
            logInfo = "未知错误";
          }
        }
      } else {
        logInfo = "未能收到服务器响应，请检查网络连接";
      }
      if(logInfo != ""){
        Get.dialog(AlertDialog(
          title: Text("发生错误"),
          content: Text(logInfo),
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
      update();
    } else {
      Get.dialog(AlertDialog(
        title: Text("无已保存的密钥"),
        content: Text("您还未添加您的百度翻译开放平台开发者密钥，请先添加并保存信息!"),
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

  String _generateSalt(int length) {
    const chars = '0123456789';
    Random random = Random();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  String generateSign(String appID, String key, String query, String salt) {
    String str = appID + query + salt + key;
    String data = md5.convert(utf8.encode(str)).toString();
    return data;
  }
}
