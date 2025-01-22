import 'package:swust_link/common/routes/app_pages.dart';

class AppState {
  final appNewList = [
    {
      "label": "一站式",
      "children": [
        {"route": AppRoutes.MAIN + AppRoutes.CLASS_TABLE, "text": "课程表"},
        {"route": AppRoutes.MAIN + AppRoutes.CHOOSE_CLSS_TABLE, "text": "选课课表"},
        {"route": AppRoutes.MAIN + AppRoutes.CLASS_SCORE, "text": "成绩查询"},
        {"route": AppRoutes.MAIN + AppRoutes.EXAM, "text": "考试查询"},
        {"route": AppRoutes.MAIN + AppRoutes.EVALUATE_ONLINE, "text": "教学评价"},
        {"route": AppRoutes.MAIN + AppRoutes.JUDGE_SCORE, "text": "综合测评"},
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
      "label": "学习通",
      "children": [
        {"route": AppRoutes.MAIN + AppRoutes.COMING_SOON, "text": "学习通课程"},
        {"route": AppRoutes.MAIN + AppRoutes.COMING_SOON, "text": "学习通作业"},
      ]
    },
    {
      "label": "实用",
      "children": [
        {"route": AppRoutes.MAIN + AppRoutes.VARIABLE_NAME, "text": "起个变量名"},
        {"route": AppRoutes.MAIN + AppRoutes.SCHOOL_MAP, "text": "学校地图"},
        {"route": AppRoutes.MAIN + AppRoutes.GYDB_PAGE, "text": "舍先生"}
      ]
    }
  ];
}
