import 'package:get/get.dart';
import 'package:swust_link/common/entity/oa/exam.dart';
import 'package:swust_link/spider/exam_table.dart';

class ExamState {
  late ExamTable examTable;
  final exams = <FinalExam>[].obs;
}
