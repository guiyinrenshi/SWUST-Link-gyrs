import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:swust_link/common/entity/sjjx/course_frame.dart';
import 'package:swust_link/spider/sjjx_class_table.dart';

class SJJXSelectClassLogic extends GetxController {
  final courseList = <CourseFrame>[].obs;
  final isLoading = true.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    courseList.value = (await (await SJJXTable.getInstance())?.getCourseFrameList())!;
    isLoading.value = false;
    Logger().i(courseList);
  }

}
