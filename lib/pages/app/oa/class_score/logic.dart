import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swust_link/common/entity/oa/score.dart';
import 'package:swust_link/common/routes/app_pages.dart';
import 'package:swust_link/spider/class_score.dart';

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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? username = prefs.getString('0username');
    final String? password = prefs.getString('0password');
    if (username != null && password != null) {
      // state.scores.value = await loadCoursesFromLocal();
      state.classScore = ClassScore(username, password);
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

  Future<void> saveCoursesToLocal(List<dynamic> courseScores) async {
    try {
      // 获取应用的文档目录
      final directory = await getApplicationDocumentsDirectory();
      final filePath = "${directory.path}/courseScore.json";

      // 将课程数据转为 JSON 字符串
      final jsonString =
      jsonEncode(courseScores.map((courseScore) => courseScore.toJson()).toList());

      // 写入本地文件
      final file = File(filePath);
      await file.writeAsString(jsonString);

      print("Courses saved to $filePath");
    } catch (e) {
      print("Failed to save courses: $e");
    }
  }

  Future<List<CourseScore>> loadCoursesFromLocal() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = "${directory.path}/courseScore.json";
      print(filePath);
      final file = File(filePath);

      if (await file.exists()) {
        print("从缓存中读取");
        final jsonString = await file.readAsString();
        final List<dynamic> jsonList = jsonDecode(jsonString);
        print(jsonList);
        // 将 JSON 列表转换为 Course 列表
        var data = jsonList.map((json) => CourseScore.fromJson(json)).toList();
        Logger().i(data);
        return data;
      } else {
        print("本地分数文件不存在。");
        return [];
      }
    } catch (e) {
      print("读取分数数据失败: $e");
      return [];
    }
  }
  Future<void> loadFromLocal() async{
    try{
      state.scores.value = await loadCoursesFromLocal();
      updateSelectedSemester(state.scores.first.semester);
    } catch(e){
      Get.snackbar("获取缓存失败", "本地暂无分数缓存信息! ");
    }
  }

  Future<void> getScore() async {
    loadCoursesFromLocal();
    try{
      var data =  await state.classScore.getScoreList();
      if (data.isNotEmpty){
        state.scores.value = data;
        await saveCoursesToLocal(state.scores);
        updateSelectedSemester(state.scores.first.semester);
      }
    } catch(e){
      Get.snackbar("获取失败", "请刷新重试或检查网络连接! ");
      loadCoursesFromLocal();
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
        courseCount += double.tryParse(course.credit) ?? 0.0;
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
