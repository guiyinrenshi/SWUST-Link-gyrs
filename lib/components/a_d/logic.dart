import 'dart:math';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

class ADLogic extends GetxController {
  final ads = [].obs;

  final currentAd = {}.obs;
  late Dio dio;

  @override
  void onInit() {
    super.onInit();
    dio = Dio();
    loadNotice();
  }
  Future<void> openInBrowser(url) async {
    if (await canLaunch(  url)) {
      await launch( url);
    } else {
      Get.snackbar("错误", "无法在浏览器中打开链接");
    }
  }
  Future<void> loadNotice() async {
    final noticeUrl =
        "https://alist.yudream.online/d/%E6%B8%B8%E5%AE%A2%E4%B8%BB%E7%9B%AE%E5%BD%95/SWUST%20Link/%E6%95%B0%E6%8D%AE%E6%96%87%E4%BB%B6/notice.json?sign=k5EQzbxUsNah8wQL5XF886yqDemxG2jWhvNtvL63tqg=:0";
    final res = await dio.get(noticeUrl);
    Logger().i(res.data['notice']);
    try {
      ads.value = res.data['ads'];
      if(ads.isNotEmpty){
        final randomIndex = Random().nextInt(ads.length);
        currentAd.value = ads[randomIndex];
      }

    } catch (e) {}
  }
}
