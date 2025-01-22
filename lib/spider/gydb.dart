import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:swust_link/common/entity/gydb/df.dart';
import 'package:swust_link/common/entity/gydb/gydb_account.dart';
import 'package:swust_link/common/routes/app_pages.dart';

import '../common/global.dart';

class GYDB {
  final String username;
  final String password;
  late String token;
  late Dio dio;
  late UserAccount userAccount;
  final imgUrl = "http://gydb.swust.edu.cn/AppApi/images/qrCode/";

  GYDB({required this.username, required this.password}) {
    dio = Dio();
  }

  Future<Map<String, dynamic>> login() async {
    final url = "http://gydb.swust.edu.cn/AppApi/api/login";
    var payload = {"username": username, "password": generateMD5(password)};
    final res = await dio.post(url, data: payload);
    final flag = res.data['flag'];
    if (flag) {
      token = res.data['data']['access_token'];
      String userAccountString = res.data['data']['UserAccount'];
      Map<String, dynamic> userAccountJson = json.decode(userAccountString);
      userAccount = UserAccount.fromJson(userAccountJson);
      return {"msg": "登录成功", "flag": true};
    } else {
      return {"msg": res.data['msg'], "flag": false};
    }
  }

  String getQrCodeUrl() {
    return imgUrl + userAccount.userName;
  }

  Future<DianFei> getDF() async {
    final url = "http://gydb.swust.edu.cn/AppApi/api/cost/search_dianfei";
    final headers = {"Authorization": "bearer $token"};
    final res = await dio.post(url, options: Options(headers: headers));
    return DianFei.fromJson(res.data['data']);
  }

  String generateMD5(String data) {
    Uint8List content = Utf8Encoder().convert(data);
    Digest digest = md5.convert(content);
    return digest.toString();
  }

  static GYDB? gydb;

  static Future<GYDB?> getGydb() async {
    if (gydb == null) {
      String? username = Global.prefs.getString("3username");
      String? password = Global.prefs.getString("3password");
      if (username != null && password != null) {
        gydb = GYDB(username: username, password: password);
        final res = await gydb?.login();
        Logger().i(res);
      } else {
        Get.dialog(AlertDialog(
          title: Text("未登录"),
          content: Text("舍先生还未登录，请先前去登录!"),
          actions: [
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("取消")),
            TextButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.MAIN+AppRoutes.ACCOUNT);
                },
                child: Text("前去登录"))
          ],
        ));
        return null;
      }
    }
    return gydb;
  }
}
