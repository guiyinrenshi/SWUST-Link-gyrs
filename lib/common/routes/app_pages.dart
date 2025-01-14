import 'package:get/get.dart';
import 'package:swust_link/pages/coming_soon/view.dart';
import 'package:swust_link/pages/duifene/duifene_course/view.dart';
import 'package:swust_link/pages/duifene/duifene_paper/view.dart';
import 'package:swust_link/pages/duifene/duifene_work/view.dart';

import 'package:swust_link/pages/main/view.dart';
import 'package:swust_link/pages/mine/about/view.dart';
import 'package:swust_link/pages/mine/login/view.dart';
import 'package:swust_link/pages/mine/params_setting/view.dart';
import 'package:swust_link/pages/mine/privacy_and_protocol/view.dart';
import 'package:swust_link/pages/oa/class_score/view.dart';
import 'package:swust_link/pages/oa/class_table/view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.MAIN;

  static final routes = [
    GetPage(name: AppRoutes.MAIN, page: () => MainPage(), children: [
      GetPage(name: AppRoutes.ACCOUNT, page: () => LoginPage()),
      GetPage(name: AppRoutes.DUIFENE_WORK, page: () => DuifeneWorkPage()),
      GetPage(name: AppRoutes.DUIFENE_COURSE, page: () => DuifeneCoursePage()),
      GetPage(name: AppRoutes.DUIFENE_PAPER, page: () => DuifenePaperPage()),
      GetPage(name: AppRoutes.CLASS_TABLE, page: () => ClassTablePage()),
      GetPage(name: AppRoutes.PARAMS_SETTING, page: () => Params_settingPage()),
      GetPage(
          name: AppRoutes.PRIVACY_AND_PROTOCOL,
          page: () => PrivacyAndProtocolPage()),
      GetPage(name: AppRoutes.CLASS_SCORE, page: () => ClassScorePage()),
      GetPage(name: AppRoutes.ABOUT, page: () => AboutPage()),
      GetPage(name: AppRoutes.COMING_SOON, page: () => ComingSoonPage())
    ])
  ];
}
