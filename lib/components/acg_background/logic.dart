import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swust_link/common/global.dart';

import 'state.dart';

class AcgBackgroundLogic extends GetxController {
  final AcgBackgroundState state = AcgBackgroundState();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    randomBG();
    // setHandelBG();
  }
  void randomBG(){
    Logger().i(state.assets);
    // 生成随机索引
    final randomIndex = Random().nextInt(state.assets.length);
    // 更新随机背景图片
    state.image.value = state.assets[randomIndex];
  }
  // Future<void> setHandelBG() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final isUploadBg = prefs.getBool("isUploadBg") ?? false;
  //   Logger().i("isUploadBg:$isUploadBg");
  //   if (isUploadBg) {
  //     final uploadBgPath = prefs.getString("uploadBgPath") ?? "";
  //     Logger().i("Get UploadBgPath:$uploadBgPath");
  //     if(uploadBgPath != ""){
  //         state.imagePath.value = File(uploadBgPath);
  //     }
  //   }
  // }
}
