import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swust_link/spider/duifene.dart';
import 'package:swust_link/spider/oa_auth.dart';

import '../utils/local_sttorage.dart';

class Global {
  static late OAAuth? oa;
  static bool isLoginOA = false;
  static late DuiFenE? duiFenE;
  static bool isLoginDfe = false;
  static late SharedPreferences prefs;
  static late LocalStorageService localStorageService;

  static Future<void> initialize() async {
    localStorageService = LocalStorageService();
    prefs = await SharedPreferences.getInstance();
    initOA();
    initDuifene();
  }

  static Future<void> initOA() async {
    final now = DateTime.now();
    final currentHour = now.hour;
    if (currentHour < 8 || currentHour >= 24) {
      Get.snackbar("提示", "当前一站式已关闭, 将加载缓存数据");
      return;
    }
    String? username = prefs.getString("0username");
    String? password = prefs.getString("0password");
    if (username != null && password != null) {
      Logger().i(username + password);
      oa = OAAuth(service: "", username: username, password: password);
      var isSuccess = await oa?.login() ?? false;
      if (isSuccess) {
        await Global.getOAService(
            "https://matrix.dean.swust.edu.cn/acadmicManager/index.cfm?event=studentPortal:DEFAULT_EVENT");
        isLoginOA = true;
      } else {
        Get.dialog(AlertDialog(
          title: Text("登录OA失败"),
          content: Text("点击尝试重新登录，或只查看缓存数据"),
          actions: [
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("只看缓存")),
            TextButton(
                onPressed: () {
                  initOA();
                  Get.back();
                },
                child: Text("重新登录"))
          ],
        ));
        return;
      }
    } else {
      Get.snackbar("未登录", "请先在我的-账号信息中保存登录信息");
      return;
    }
  }

  static Future<bool> getOAService(String service) async {
    var response = await oa?.dio.get("http://cas.swust.edu.cn/authserver/login",
        queryParameters: {"service": service});
    final maxRedirects = 5; // 最大重定向次数
    var currentRedirects = 0;
    while (response?.statusCode == 302 || response?.statusCode == 301) {
      if (currentRedirects >= maxRedirects) {
        throw Exception('Too many redirects');
      }
      final location = response?.headers['location']?.first;
      if (location == null) {
        throw Exception('No Location header found for redirect');
      }
      // 构造新的 URL
      final newUrl = Uri.parse(location).isAbsolute
          ? location
          : Uri.parse(response!.realUri.toString())
              .resolve(location)
              .toString();
      // 发起重定向请求，保持方法一致
      response = await oa?.dio.get(newUrl);
      currentRedirects++;
    }
    Logger().i(response?.requestOptions.uri.toString());
    return response?.statusCode == 200;
  }

  static Future<void> initDuifene() async {
    String? username = prefs.getString("1username");
    String? password = prefs.getString("1password");
    if (username != null && password != null) {
      Logger().i(username + password);
      duiFenE = DuiFenE(username: username, password: password);
      isLoginDfe = await duiFenE?.passwordLogin() ?? false;
    }
  }
}
