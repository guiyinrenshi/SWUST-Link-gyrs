import 'package:get/get.dart';
import 'package:swust_link/pages/app/duifene/duifene_course/view.dart';
import 'package:swust_link/pages/app/duifene/duifene_paper/view.dart';
import 'package:swust_link/pages/app/duifene/duifene_work/view.dart';
import 'package:swust_link/pages/app/oa/class_score/view.dart';
import 'package:swust_link/pages/app/oa/class_table/view.dart';
import 'package:swust_link/pages/app/oa/evaluate_online/view.dart';
import 'package:swust_link/pages/app/oa/exam/view.dart';
import 'package:swust_link/pages/app/oa/judge_score/view.dart';
import 'package:swust_link/pages/app/oa/leave_application/view.dart';
import 'package:swust_link/pages/app/oa/leave_info/view.dart';
import 'package:swust_link/pages/app/oa/sjjx_select_class/view.dart';
import 'package:swust_link/pages/app/tool_app/club_page/view.dart';
import 'package:swust_link/pages/app/tool_app/gydb/view.dart';
import 'package:swust_link/pages/common/app_settings/view.dart';
import 'package:swust_link/pages/common/coming_soon/view.dart';
import 'package:swust_link/pages/common/markdown_temple/view.dart';

import 'package:swust_link/pages/app/tool_app/variable_name/view.dart';
import 'package:swust_link/pages/common/web_view_common/view.dart';
import 'package:swust_link/pages/main/view.dart';
import 'package:swust_link/pages/mine/about/view.dart';
import 'package:swust_link/pages/mine/login/view.dart';
import 'package:swust_link/pages/mine/params_setting/font_size_setting/view.dart';
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
          page: () =>
              ClassTablePage("课程表",
                  "https://matrix.dean.swust.edu.cn/acadmicManager/index.cfm?event=studentPortal:courseTable")),
      GetPage(
          name: AppRoutes.CHOOSE_CLSS_TABLE,
          page: () =>
              ClassTablePage("选课课表",
                  "https://matrix.dean.swust.edu.cn/acadmicManager/index.cfm?event=chooseCourse:courseTable")),
      GetPage(name: AppRoutes.PARAMS_SETTING, page: () => Params_settingPage()),
      GetPage(name: AppRoutes.JUDGE_SCORE, page: () => JudgeScorePage()),
      GetPage(name: AppRoutes.YKT,
          page: () =>
              WebViewCommonPage(title: "一卡通",
                initUrl: "http://ykt.swust.edu.cn/plat/shouyeUser",)),
      GetPage(name: AppRoutes.VARIABLE_NAME, page: () => VariableNamePage()),
      GetPage(name: AppRoutes.SCHOOL_MAP,
          page: () =>
              WebViewCommonPage(title: "学校地图",
                  initUrl: "https://gis.swust.edu.cn/#/home?campus=78924")),
      GetPage(
          name: AppRoutes.PRIVACY_AND_PROTOCOL,
          page: () =>
              MarkdownTemplePage(
                  "隐私与协议", "assets/privacy_and_protocol_state.md")),
      GetPage(name: AppRoutes.CLASS_SCORE, page: () => ClassScorePage()),
      GetPage(name: AppRoutes.GYDB_PAGE, page: () => GydbPage()),
      GetPage(name: AppRoutes.CLUB_NAV, page: () => ClubPagePage()),
      GetPage(name: AppRoutes.LEAVE_PAGE, page: () => LeaveApplicationPage()),
      GetPage(name: AppRoutes.LEAVE_INFO_PAGE, page: () => LeaveInfoPage()),
      GetPage(name: AppRoutes.ABOUT, page: () => AboutPage()),
      GetPage(name: AppRoutes.COMING_SOON, page: () => ComingSoonPage()),
      GetPage(name: AppRoutes.COURSE_FRAME, page: () => SJJXSelectClassPage()),

      GetPage(name: AppRoutes.APP_SETTING, page: () => AppSettingsPage()),
      GetPage(
          name: AppRoutes.UPDATE_LOGS,
          page: () => MarkdownTemplePage("更新日志", "assets/update.md")),
      GetPage(name: AppRoutes.EXAM, page: () => ExamPage()),
      GetPage(
          name: AppRoutes.LOGIN_TIP,
          page: () => MarkdownTemplePage("登录说明", "assets/login_tip.md")),
      GetPage(
          name: AppRoutes.EVALUATE_ONLINE, page: () => EvaluateOnlinePage()),
      GetPage(name: AppRoutes.FONT_SIZE_SETTING, page: () => FontSizeSettingPage()),
      for (var item in urls)
        GetPage(
            name: item['route']!,
            page: () =>
                WebViewCommonPage(title: item['title']!, initUrl: item['url']!))
    ])
  ];

  static final urls = [
    {
      "title": "本科招生",
      "url": "https://zs.swust.edu.cn/#/",
      "route": "/app/zs"
    },
    {
      "title": "计科社团",
      "url": "https://wiki.yudream.online/",
      "route": "/app/computer/science/society"
    },
    {"title": "一生一芯", "url": "https://ysyx.oscc.cc/", "route": "/app/ysyx"},
    {
      "title": "掌上西科",
      "url": "https://swust.devin.cool/#/",
      "route": "/app/zsxk"
    }
  ];
}
