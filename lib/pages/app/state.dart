import 'package:swust_link/common/routes/app_pages.dart';

class AppState {
  static final appNewList = [
    {
      "label": "一站式",
      "children": [
        {"route": AppRoutes.MAIN + AppRoutes.CLASS_TABLE, "text": "课程表"},
        {"route": AppRoutes.MAIN + AppRoutes.CHOOSE_CLSS_TABLE, "text": "选课课表"},
        {"route": AppRoutes.MAIN + AppRoutes.CLASS_SCORE, "text": "成绩查询"},
        {"route": AppRoutes.MAIN + AppRoutes.EXAM, "text": "考试查询"},
        {"route": AppRoutes.MAIN + AppRoutes.EVALUATE_ONLINE, "text": "教学评价"},
        {"route": AppRoutes.MAIN + AppRoutes.JUDGE_SCORE, "text": "综合测评"},
        {"route": AppRoutes.MAIN + AppRoutes.LEAVE_INFO_PAGE, "text": "日常请假"},
      ]
    },
    {
      "label": "对分易",
      "children": [
        {"route": AppRoutes.MAIN + AppRoutes.DUIFENE_COURSE, "text": "对分易课程"},
        {"route": AppRoutes.MAIN + AppRoutes.DUIFENE_WORK, "text": "对分易作业"},
        {"route": AppRoutes.MAIN + AppRoutes.DUIFENE_PAPER, "text": "对分易练习"}
      ]
    },
    {
      "label": "实用",
      "children": [
        {"route": AppRoutes.MAIN + AppRoutes.YKT, "text": "一卡通"},
        {"route": AppRoutes.MAIN + AppRoutes.GYDB_PAGE, "text": "舍先生"},
        {"route": AppRoutes.MAIN + AppRoutes.SCHOOL_MAP, "text": "学校地图"},
        {"route": AppRoutes.MAIN + AppRoutes.VARIABLE_NAME, "text": "起个变量名"},
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
}
