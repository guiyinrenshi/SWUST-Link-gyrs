import 'package:get/get.dart';
import 'package:swust_link/common/entity/score.dart';
import 'package:swust_link/spider/class_score.dart';

class ClassScoreState {
  late ClassScore classScore;
  // final RxList<AcademicRecord> scores = <AcademicRecord>[].obs;
  final scores = <CourseScore>[].obs;
  final selectedSemester = "".obs;
  final displayList  = <CourseScore>[].obs;

  var averageGPA = 0.0.obs;
}
