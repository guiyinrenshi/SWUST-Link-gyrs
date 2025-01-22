import 'package:get/get.dart';
import 'package:swust_link/common/global.dart';
import 'package:swust_link/spider/class_score.dart';
import 'package:swust_link/spider/exam_table.dart';
import 'package:swust_link/spider/oa_auth.dart';

import 'class_table.dart';
import 'evaluate_online.dart';

class MatrixOa {
  final OAAuth oa;
  late final EvaluateOnline evaluateOnline;
  late final ExamTable examTable;
  late final ClassScore classScore;
  late final UndergraduateClassTable undergraduateClassTable;
  MatrixOa(this.oa){
    evaluateOnline = EvaluateOnline(oa);
    examTable = ExamTable(oa);
    classScore = ClassScore(oa);
    undergraduateClassTable = UndergraduateClassTable(oa);
  }

  static MatrixOa? matrixOa;

  static Future<MatrixOa?> getInstance() async {
    if (matrixOa == null) {
      String? username = Global.prefs.getString("0username");
      String? password = Global.prefs.getString("0password");
      if (username != null && password != null) {
        var oa = OAAuth(
            service: "https://matrix.dean.swust.edu.cn/acadmicManager/index.cfm?event=studentPortal:DEFAULT_EVENT",
            username: username,
            password: password);
        if (await oa.login()) {
          matrixOa = MatrixOa(oa);
        } else{
          Get.snackbar("登录失效", "请尝试刷新或检查账号密码是否正确!");
        }
      }
    }
    return matrixOa;
  }
}
