import 'package:get/get.dart';
import 'package:swust_link/common/entity/oa/judge_score.dart';
import 'package:swust_link/spider/xsc_oa.dart';

class JudgeScoreState {
// 所有记录
  final RxList<JudgeScore> records = <JudgeScore>[].obs;

  // 当前选中记录
  final Rx<JudgeScore?> selectedRecord = Rx<JudgeScore?>(null);
  final RxString selectedFilter = "成绩".obs;

}
