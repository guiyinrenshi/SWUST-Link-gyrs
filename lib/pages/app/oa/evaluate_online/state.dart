import 'package:get/get.dart';
import 'package:swust_link/common/entity/oa/evaluation_paper.dart';
import 'package:swust_link/spider/evaluate_online.dart';

class EvaluateOnlineState {
  final evaluatePaperList = <EvaluationPaper>[].obs;
  final isLoading = true.obs;
}
