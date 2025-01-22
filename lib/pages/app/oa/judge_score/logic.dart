import 'package:get/get.dart';
import 'package:swust_link/common/entity/oa/judge_score.dart';
import 'package:swust_link/common/global.dart';
import 'package:swust_link/spider/xsc_oa.dart';
import 'state.dart';

class JudgeScoreLogic extends GetxController {
  final JudgeScoreState state = JudgeScoreState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getJudgeScore();
  }

  Future<void> getJudgeScore() async {
    loadRecords();
  }

  // 加载数据（可以替换为实际的数据来源）
  void loadRecords() async {
    state.records.value = await Global.localStorageService
        .loadFromLocal("judgeScore", (json) => JudgeScore.fromJson(json));
    if (state.records.isNotEmpty) {
      state.selectedRecord.value = state.records.first;
    }

    final data = await (await XSCOA.getInstance())!.getJudgeScore();
    if (data.isNotEmpty) {
      Global.localStorageService.saveToLocal(data, "judgeScore");
      state.records.value = data;
      state.selectedRecord.value = data.first;
    }
  }

  // 更新选中记录
  void updateSelectedRecord(String academicYear) {
    final record =
        state.records.firstWhereOrNull((r) => r.academicYear == academicYear);
    state.selectedRecord.value = record;
  }
}
