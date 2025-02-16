import 'dart:math';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:swust_link/common/entity/sjjx/course_frame.dart';

import '../../../../../../spider/sjjx_class_table.dart';

class Class_selectLogic extends GetxController {
  final courseList = <Experiment>[].obs;
  final isLoading = true.obs;

  void getData(id, exp) async{
    courseList.value = (await (await SJJXTable.getInstance())?.getExperimentList(id, exp))!;
    isLoading.value = false;
  }
}
