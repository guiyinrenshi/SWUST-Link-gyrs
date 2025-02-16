import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:swust_link/common/entity/sjjx/course_frame.dart';

import '../../../../../spider/sjjx_class_table.dart';

class ClassSelectInfoLogic extends GetxController {
  final courseList = <ExperimentProject>[].obs;
  final isLoading = true.obs;

  void getData(id) async{
    courseList.value = (await (await SJJXTable.getInstance())?.getCourseProject(id))!;
    isLoading.value = false;
    Logger().i(courseList);
  }
}
