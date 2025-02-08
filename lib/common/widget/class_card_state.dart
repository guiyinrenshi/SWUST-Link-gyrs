import 'package:get/get.dart';
import 'package:swust_link/common/entity/oa/course.dart';

class ClassCardState {
  final time = 1.obs;
  final className = "课程".obs;
  final placeName = "地点".obs;

  final todayCourseList = <Course>[].obs;
  final currentTime = DateTime.now().obs;

  final int classDuration = 100; // 每节课的时长（分钟）

  final List<DateTime> courseTimes = [
    DateTime(0, 0, 0, 8, 0),  // 8:00
    DateTime(0, 0, 0, 10, 0), // 10:00
    DateTime(0, 0, 0, 14, 0), // 14:00
    DateTime(0, 0, 0, 16, 0), // 16:00
    DateTime(0, 0, 0, 19, 0), // 19:00
    DateTime(0, 0, 0, 21, 0), // 21:00
  ];
}
