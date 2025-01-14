import 'package:get/get.dart';
import 'package:swust_link/common/entity/oa/course.dart';

class HomeState {
  final firstDay = DateTime.now().obs;
  final toDayCourses = <Course>[].obs;
  final backgroundUrl = "".obs;
}
