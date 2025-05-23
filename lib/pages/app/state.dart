import 'package:get/get.dart';
import 'package:swust_link/common/routes/app_pages.dart';

class AppState {
  static final appNewList = [
    {
      "label": "一站式",
      "children": [
        {
          "route": AppRoutes.MAIN + AppRoutes.CLASS_TABLE,
          "text": "课程表",
          "icon": "课程表"
        },
        {
          "route": AppRoutes.MAIN + AppRoutes.CHOOSE_CLSS_TABLE,
          "text": "选课课表",
          "icon": "选课课表"
        },
        {
          "route": AppRoutes.MAIN + AppRoutes.CLASS_SCORE,
          "text": "成绩查询",
          "icon": "成绩查询"
        },
        {
          "route": AppRoutes.MAIN + AppRoutes.EXAM,
          "text": "考试查询",
          "icon": "考试"
        },
        {
          "route": AppRoutes.MAIN + AppRoutes.EVALUATE_ONLINE,
          "text": "教学评价",
          "icon": "评价"
        },
        {
          "route": AppRoutes.MAIN + AppRoutes.JUDGE_SCORE,
          "text": "综合测评",
          "icon": "综合测评"
        },
        {
          "route": AppRoutes.MAIN + AppRoutes.LEAVE_INFO_PAGE,
          "text": "日常请假",
          "icon": "请假申请"
        },
        {
          "route": AppRoutes.MAIN + AppRoutes.COURSE_FRAME,
          "text": "实践选课",
          "icon": "选课"
        },
      ]
    },
    {
      "label": "对分易",
      "children": [
        {"route": AppRoutes.MAIN + AppRoutes.DUIFENE_COURSE, "text": "对分易课程","icon": "课程"},
        {"route": AppRoutes.MAIN + AppRoutes.DUIFENE_WORK, "text": "对分易作业","icon": "作业"},
        {"route": AppRoutes.MAIN + AppRoutes.DUIFENE_PAPER, "text": "对分易练习","icon": "练习"}
      ]
    },
    {
      "label": "实用",
      "children": [
        {"route": AppRoutes.MAIN + AppRoutes.YKT, "text": "一卡通", "icon": "一卡通"},
        {"route": AppRoutes.MAIN + AppRoutes.GYDB_PAGE, "text": "舍先生","icon": "宿舍"},
        {"route": AppRoutes.MAIN + AppRoutes.SCHOOL_MAP, "text": "学校地图","icon": "地图"},
        {"route": AppRoutes.MAIN + AppRoutes.VARIABLE_NAME, "text": "起个变量名","icon": "语言翻译"},
        {"route": AppRoutes.MAIN + AppRoutes.CLUB_NAV, "text": "社团导航","icon": "导航"},
      ]
    },
    {
      "label": "友情链接",
      "children": [
        for (var item in AppPages.urls)
          {"route": AppRoutes.MAIN + item['route']!, "text": item['title']}
      ]
    }
  ];

  var screenWidth = 0.0.obs; // 确保它是 .obs
}
