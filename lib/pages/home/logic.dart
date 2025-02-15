import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swust_link/common/entity/oa/course.dart';
import 'package:swust_link/common/global.dart';
import 'package:swust_link/pages/home/state.dart';
import 'package:swust_link/spider/class_table.dart';
import 'package:http/http.dart' as http;

class HomeLogic extends GetxController {
  final HomeState state = HomeState();

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await loadFirstDay();
    state.toDayCourses.value = await getTodayCourses();
  }

  Future<void> loadFirstDay() async {
    final prefs = await SharedPreferences.getInstance();
    final firstDayString = prefs.getString("firstDay");
    try {
      state.firstDay.value = DateTime.parse(firstDayString!);
    } catch (e) {
      print(e);
    }
  }


  Future<List<Course>> getTodayCourses() async {
    final courses = await Global.localStorageService
        .loadFromLocal("课程表-courses", (json) => Course.fromJson(json));
    // Logger().i(courses);
    // 计算当前周和星期几
    final today = DateTime.now();
    final daysSinceFirstDay = today.difference(state.firstDay.value).inDays;

    Logger().i(daysSinceFirstDay);
    if (daysSinceFirstDay<0){
      return [];
    } else {
      final currentWeek = (daysSinceFirstDay ~/ 7) + 1;
      final todayWeekday = today.weekday; // 1 = 周一, 7 = 周日

      // 筛选今天的课程
      return courses.where((course) {
        final courseStartWeek = int.parse(course.startTime);
        final courseEndWeek = int.parse(course.endTime);

        return course.weekDay == todayWeekday &&
            currentWeek >= courseStartWeek &&
            currentWeek <= courseEndWeek;
      }).toList();
    }
  }
}
