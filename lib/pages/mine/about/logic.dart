import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import 'state.dart';



class AboutLogic extends GetxController {
  final AboutState state = AboutState();

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await _fetchAppInfo();
  }

  Future<void> _fetchAppInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    state.appName.value = packageInfo.appName;
    state.packageName.value = packageInfo.packageName;
    state.version.value = packageInfo.version;
    state.buildNumber.value = packageInfo.buildNumber;
  }

  void launch(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw '无法打开链接: $url';
    }
  }

  void callQQ({int number = 950969163, bool isGroup = true}) async {
    String url = isGroup
        ? 'mqqapi://card/show_pslcard?src_type=internal&version=1&uin=${number ?? 0}&card_type=group&source=qrcode'
        : 'mqqwpa://im/chat?chat_type=wpa&uin=${number ?? 0}&version=1&src_type=web&web_src=oicqzone.com';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      Get.snackbar("错误", "未检测到 QQ 应用，请安装后重试。");
    }
  }

  Future<void> requestPermissions() async {
    if (!await Permission.storage.request().isGranted) {
      throw Exception("存储权限未授予");
    }
  }
  Future<void> updateNew() async {
    Get.back();

  }

  Future<void> checkNew() async {
    Dio dio = Dio();
    try {
      var res = await dio.get("http://notice.yudream.online/file_info.json");
      var data = res.data;
      state.newLabel.value = data['label'];
      state.newFileName.value = data['fileName'];
      state.newUrl.value = data['url'];

      var isNew = state.newLabel.value !=
          "${state.version.value}+${state.buildNumber.value}";

      Get.dialog(AlertDialog(
        title: Text(isNew ? "发现新版本" : "暂无新版本"),
        content: Text(isNew ? "新版本${state.newLabel.value}" : "当前版本已经是最新版本!"),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // 关闭弹窗
            },
            child: Text("取消"),
          ),
          isNew
              ? TextButton(
            onPressed: () async {
              final url = state.newUrl.value;
              if (await canLaunchUrl(Uri.parse(url))) {
                Get.back();
                await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
              } else {
                Get.snackbar("错误", "无法打开浏览器访问下载地址");
              }
            },
            child: Text("跳转下载"),
          )
              : TextButton(onPressed: (){Get.back();}, child: Text("确定")),
        ],
      ));
    } catch (e) {
      Get.snackbar("错误", "获取版本信息错误!");
      Logger().e(e);
      return;
    }
  }
}
