import 'package:get/get.dart';
import 'package:swust_link/common/entity/oa/leave_info.dart';
import 'package:swust_link/spider/xsc_oa.dart';

import 'state.dart';

class LeaveInfoLogic extends GetxController {
  final LeaveInfoState state = LeaveInfoState();

  @override
  void onInit() {
    super.onInit();
    fetchRecords();
  }

  // 模拟数据获取
  void fetchRecords() async {
    state.isLoading.value = true;
    LeaveInfoRecord leaveInfoRecord = await (await XSCOA.getInstance())!
        .xscLeave
        .getAllLeave(state.currentPage.value);
    state.isLoading.value = false;
    // 假设总页数为 5，每页有 2 条记录
    state.totalPages.value = leaveInfoRecord.paginationInfo.totalPages;
    state.records.value = leaveInfoRecord.records;
  }

  void nextPage() {
    if (state.currentPage.value < state.totalPages.value) {
      state.currentPage.value++;
      fetchRecords();
    }
  }

  void previousPage() {
    if (state.currentPage.value > 1) {
      state.currentPage.value--;
      fetchRecords();
    }
  }
}
