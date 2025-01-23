import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewCommonLogic extends GetxController {
  final  title = "".obs;
  final  initUrl = "".obs;
  late final WebViewController controller;

  Future<void> openInBrowser() async {
    if (await canLaunch(  (await controller.currentUrl())!)) {
      await launch( (await controller.currentUrl())!);
    } else {
      Get.snackbar("错误", "无法在浏览器中打开链接");
    }
  }

  Future<void> copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: (await controller.currentUrl())!));
    Get.snackbar("提示", "链接已复制到剪贴板");
  }
}
