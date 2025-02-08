import 'dart:convert';
import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:swust_link/spider/class_table.dart';

import 'state.dart';

class AppLogic extends GetxController {
  final AppState state = AppState();
  void updateScreenWidth() {
    state.screenWidth.value = ScreenUtil().screenWidth; // 更新屏幕宽度
  }




}
