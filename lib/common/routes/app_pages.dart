import 'package:get/get.dart';
import 'package:swust_link/pages/app/duifene/duifene_course/view.dart';
import 'package:swust_link/pages/app/duifene/duifene_paper/view.dart';
import 'package:swust_link/pages/app/duifene/duifene_work/view.dart';
import 'package:swust_link/pages/app/oa/class_score/view.dart';
import 'package:swust_link/pages/app/oa/class_table/view.dart';
import 'package:swust_link/pages/app/oa/evaluate_online/view.dart';
import 'package:swust_link/pages/app/oa/exam/view.dart';
import 'package:swust_link/pages/common/coming_soon/view.dart';
import 'package:swust_link/pages/common/markdown_temple/view.dart';

import 'package:swust_link/pages/app/tool_app/variable_name/view.dart';
import 'package:swust_link/pages/main/view.dart';
import 'package:swust_link/pages/mine/about/view.dart';
import 'package:swust_link/pages/mine/login/view.dart';
import 'package:swust_link/pages/mine/params_setting/view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.MAIN;

  static final routes = [
    GetPage(name: AppRoutes.MAIN, page: () => MainPage(), children: [
      GetPage(name: AppRoutes.ACCOUNT, page: () => LoginPage()),
      GetPage(name: AppRoutes.DUIFENE_WORK, page: () => DuifeneWorkPage()),
      GetPage(name: AppRoutes.DUIFENE_COURSE, page: () => DuifeneCoursePage()),
      GetPage(name: AppRoutes.DUIFENE_PAPER, page: () => DuifenePaperPage()),
      GetPage(
          name: AppRoutes.CLASS_TABLE,
          page: () => ClassTablePage("课程表",
              "https://matrix.dean.swust.edu.cn/acadmicManager/index.cfm?event=studentPortal:courseTable")),
      GetPage(
          name: AppRoutes.CHOOSE_CLSS_TABLE,
          page: () => ClassTablePage("选课课表",
              "https://matrix.dean.swust.edu.cn/acadmicManager/index.cfm?event=chooseCourse:courseTable")),
      GetPage(name: AppRoutes.PARAMS_SETTING, page: () => Params_settingPage()),
      GetPage(name: AppRoutes.VARIABLE_NAME, page: () => VariableNamePage()),
      GetPage(
          name: AppRoutes.PRIVACY_AND_PROTOCOL,
          page: () => MarkdownTemplePage(
              "隐私与协议", "assets/privacy_and_protocol_state.md")),
      GetPage(name: AppRoutes.CLASS_SCORE, page: () => ClassScorePage()),
      GetPage(name: AppRoutes.ABOUT, page: () => AboutPage()),
      GetPage(name: AppRoutes.COMING_SOON, page: () => ComingSoonPage()),
      GetPage(
          name: AppRoutes.UPDATE_LOGS,
          page: () => MarkdownTemplePage("更新日志", "assets/update.md")),
      GetPage(name: AppRoutes.EXAM, page: () => ExamPage()),
      GetPage(
          name: AppRoutes.LOGIN_TIP,
          page: () => MarkdownTemplePage("登录说明", "assets/login_tip.md")),
      GetPage(name: AppRoutes.EVALUATE_ONLINE, page: () => EvaluateOnlinePage())
    ])
  ];
}
