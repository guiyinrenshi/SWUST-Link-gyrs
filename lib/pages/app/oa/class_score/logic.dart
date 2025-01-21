import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swust_link/common/entity/oa/score.dart';
import 'package:swust_link/common/global.dart';
import 'package:swust_link/common/routes/app_pages.dart';
import 'package:swust_link/spider/class_score.dart';
import 'package:swust_link/utils/local_sttorage.dart';

import 'state.dart';

class ClassScoreLogic extends GetxController {
  final ClassScoreState state = ClassScoreState();

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await initScore();
    getScore();
  }

  Future<void> initScore() async {
    state.classScore = ClassScore();
  }

  Future<void> loadFromLocal() async {
    try {
      state.scores.value = await Global.localStorageService
          .loadFromLocal("courseScore", (json) => CourseScore.fromJson(json));
      updateSelectedSemester(state.scores.first.semester);
    } catch (e) {
      Get.snackbar("获取缓存失败", "本地暂无分数缓存信息! ");
    }
  }

  Future<void> getScore() async {
    await loadFromLocal();
    state.isLoading.value = false;
    try {
      var data = await state.classScore.getScoreList();
      if (data.isNotEmpty) {
        state.scores.value = data;
        await Global.localStorageService.saveToLocal(state.scores,"courseScore");
        updateSelectedSemester(state.scores.first.semester);
      }
    } catch (e) {
      Get.snackbar("获取失败", "请刷新重试或检查网络连接! ");
      loadFromLocal();
    }
  }

  // 更新当前课程数据并重新计算 GPA
  // 计算平均 GPA
  void calculateAverageGPA() {
    double totalGPA = 0.0;
    double courseCount = 0.0;

    for (var course in state.displayList) {
      if (course.gpa.isNotEmpty) {
        totalGPA += double.tryParse(course.gpa) ?? 0.0;
        var tmpCourseCount = double.tryParse(course.credit);
        courseCount += ((tmpCourseCount == 0.3 || tmpCourseCount == 0.8)?
        tmpCourseCount : (tmpCourseCount! - 0.05))!;
      } else{
        courseCount += double.tryParse(course.credit) ?? 0.0;
      }
    }

    state.averageGPA.value = courseCount > 0 ? (totalGPA / courseCount) : 0.0;
  }

  void updateSelectedSemester(String semester) {
    state.selectedSemester.value = semester;
    updateDisplayList();
    calculateAverageGPA();
  }

  void updateDisplayList() {
    final selected = state.selectedSemester.value;
    state.displayList.assignAll(
      state.scores.where((course) => course.semester == selected).toList(),
    );
  }

  List<double> getGPAList() {
    return state.displayList
        .where((course) => course.gpa.isNotEmpty)
        .map((course) => double.tryParse(course.gpa) ?? 0.0)
        .toList();
  }

  List<String> getCourseNames() {
    return state.displayList
        .where((course) => course.gpa.isNotEmpty)
        .map((course) => course.name)
        .toList();
  }
}
