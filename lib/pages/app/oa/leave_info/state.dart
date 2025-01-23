import 'package:get/get.dart';
import 'package:swust_link/common/entity/oa/leave_info.dart';

class LeaveInfoState {
  var records = <LeaveRecord>[].obs;
  var currentPage = 1.obs;
  var totalPages = 1.obs;
  var isLoading = true.obs;
}
