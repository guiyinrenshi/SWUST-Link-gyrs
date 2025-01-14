import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
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
      Get.dialog(
        AlertDialog(
          title: Text("打开QQ失败"),
          content: Text("请确保你的QQ已经安装!" ),
          actions: [
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("取消")),
          ],
        ),
      );
    }
  }
}
