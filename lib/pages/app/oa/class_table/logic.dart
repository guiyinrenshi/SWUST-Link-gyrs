import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swust_link/common/entity/oa/course.dart';
import 'package:swust_link/common/routes/app_pages.dart';
import 'package:swust_link/spider/class_table.dart';
import 'package:swust_link/utils/class_util.dart';

import 'state.dart';

class ClassTableLogic extends GetxController {
  final ClassTableState state = ClassTableState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadClassTable();
  }

  Future<void> loadClassTable() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? username = prefs.getString('0username');
    final String? password = prefs.getString('0password');
    final String? firstDay = prefs.getString("firstDay");
    if (username != null && password != null) {
      state.currentWeek.value = await loadFirstDayAndCalculateWeek();
      try {
        state.firstDay.value = DateTime.parse(firstDay!);
      } catch (e) {
        state.firstDay.value = DateTime.now();
      }

      state.undergraduateClassTable =
          UndergraduateClassTable(username: username, password: password);

      state.courses.value = await loadCoursesFromLocal();
      if (await state.undergraduateClassTable.login()) {
        state.courses.value =
            await state.undergraduateClassTable.parseClassTable();
        await saveCoursesToLocal(state.courses);
      } else {
        if (state.courses.isEmpty) {
          Get.dialog(AlertDialog(
            title: Text("登录一站式错误"),
            content: Text("请检查账号密码是否无误并修改保存! "),
            actions: [
              TextButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.MAIN + AppRoutes.ACCOUNT);
                },
                child: Text("确定"),
              ),
            ],
          ));
        } else {
          Get.snackbar("提示", "登录一站式出现问题, 已从本地缓存拉取课表");
        }
      }
    } else {
      Get.dialog(AlertDialog(
        title: Text("暂未登录"),
        content: Text("您还未登录过一站式大厅，请先登录并保存信息! "),
        actions: [
          TextButton(
            onPressed: () {
              Get.toNamed(AppRoutes.MAIN + AppRoutes.ACCOUNT);
            },
            child: Text("确定"),
          ),
        ],
      ));
    }
  }


  // List<Course> get filteredCourses {
  //   return state.courses
  //       .where((course) =>
  //           state.currentWeek.value >= int.parse(course.startTime) &&
  //           state.currentWeek.value <= int.parse(course.endTime))
  //       .toList();
  // }
  List<List<Course>> get filteredCourses {
    final groupedCourses = <String, List<Course>>{};

    for (var course in state.courses) {
      if (state.currentWeek.value >= int.parse(course.startTime) &&
          state.currentWeek.value <= int.parse(course.endTime)) {
        final key = "${course.weekDay}-${course.session}";
        groupedCourses.putIfAbsent(key, () => []).add(course);
      }
    }

    return groupedCourses.values.toList();
  }


  Color getCourseColor(String className) {
    if (!state.courseColors.containsKey(className)) {
      final index = state.courseColors.length % state.predefinedColors.length;
      state.courseColors[className] = state.predefinedColors[index];
    }
    return state.courseColors[className]!;
  }

  Future<void> saveCoursesToLocal(List<dynamic> courses) async {
    try {
      // 获取应用的文档目录
      final directory = await getApplicationDocumentsDirectory();
      final filePath = "${directory.path}/courses.json";

      // 将课程数据转为 JSON 字符串
      final jsonString =
          jsonEncode(courses.map((course) => course.toJson()).toList());

      // 写入本地文件
      final file = File(filePath);
      await file.writeAsString(jsonString);

      print("Courses saved to $filePath");
    } catch (e) {
      print("Failed to save courses: $e");
    }
  }

  Future<List<Course>> loadCoursesFromLocal() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = "${directory.path}/courses.json";

      final file = File(filePath);

      if (await file.exists()) {
        final jsonString = await file.readAsString();
        final List<dynamic> jsonList = jsonDecode(jsonString);

        // 将 JSON 列表转换为 Course 列表
        return jsonList.map((json) => Course.fromJson(json)).toList();
      } else {
        print("本地课程文件不存在。");
        return [];
      }
    } catch (e) {
      print("读取课程数据失败: $e");
      return [];
    }
  }

// 计算指定周的起始日期
  DateTime getWeekStartDate(int week) {
    // 获取第一天的 weekday（1 = 周一, 7 = 周日）
    final firstDayWeekday = state.firstDay.value.weekday;

    // 计算第一天的周一日期（回溯到第一周的周一）
    final firstMonday = state.firstDay.value.subtract(Duration(days: firstDayWeekday - 1));

    // 根据指定周数计算对应周的周一日期
    final daysToAdd = (week - 1) * 7;
    final targetDate = firstMonday.add(Duration(days: daysToAdd));

    // 如果计算结果早于第一天，返回第一天的周一
    if (targetDate.isBefore(firstMonday)) {
      return firstMonday;
    }

    return targetDate;
  }

// 设置当前周
}
