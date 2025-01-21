import 'dart:math';

import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'state.dart';

class AcgBackgroundLogic extends GetxController {
  final AcgBackgroundState state = AcgBackgroundState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    randomBG();
  }
  void randomBG(){
    Logger().i(state.assets);
    // 生成随机索引
    final randomIndex = Random().nextInt(state.assets.length);

    // 更新随机背景图片
    state.image.value = state.assets[randomIndex];
  }
}
