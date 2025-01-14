import 'package:swust_link/common/routes/app_pages.dart';

class AppState {
  final appNewList = [
    {
      "label": "一站式",
      "children": [
        {"route": AppRoutes.MAIN + AppRoutes.CLASS_TABLE, "text": "课程表"},
        {"route": AppRoutes.MAIN + AppRoutes.CLASS_SCORE, "text": "成绩查询"},
        {"route": AppRoutes.MAIN + AppRoutes.COMING_SOON, "text": "考试查询"},
        {"route": AppRoutes.MAIN + AppRoutes.COMING_SOON, "text": "教育评价"},
        // {"route": AppRoutes.MAIN + AppRoutes.COMING_SOON, "text": "教育评价"},
      ]
    },
    {
      "label": "对分易",
      "children": [
        {"route": AppRoutes.MAIN + AppRoutes.DUIFENE_COURSE, "text": "对分易课程"},
        {"route": AppRoutes.MAIN + AppRoutes.COMING_SOON, "text": "对分易作业"},
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
      ]
    }
  ];
}
