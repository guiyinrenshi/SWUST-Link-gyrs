import 'package:get/get.dart';
import 'package:swust_link/common/entity/duifene/work.dart';
import 'package:swust_link/spider/duifene.dart';

class DuifeneWorkState {
  final workList = <Work>[].obs;
  final isLoading = true.obs;
  final isShowComplete = false.obs;
}
