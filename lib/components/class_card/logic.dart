import 'package:get/get.dart';
import 'package:swust_link/common/entity/oa/course.dart';

import '../../common/widget/widget_logic.dart';
import 'state.dart';

class Class_cardLogic extends GetxController {
  final Class_cardState state = Class_cardState();

  @override
  void onInit() {
    super.onInit();
    updateCourseState();
    // 定时更新课程状态（每分钟更新一次）
    ever(state.currentTime, (_) => updateCourseState());
    state.currentTime.value = DateTime.now();
    updateEveryMinute();
  }

  void updateEveryMinute() {
    Future.delayed(Duration(milliseconds: 100), () {
      state.currentTime.value = DateTime.now();
      updateEveryMinute();
    });
  }

  void updateCourseState() {
    final now = state.currentTime.value;
    final currentTimeInMinutes = now.hour * 60 + now.minute;

    Course? currentCourse;
    Course? nextCourse;

    for (int i = 0; i < state.todayCourseList.length; i++) {
      final course = state.todayCourseList[i];
      final startDateTime = state.courseTimes[course.session - 1];

      final startHour = startDateTime.hour;
      final startMinute = startDateTime.minute;
      final startInMinutes = startHour * 60 + startMinute;
      final endInMinutes = startInMinutes + state.classDuration;

      if (currentTimeInMinutes >= startInMinutes &&
          currentTimeInMinutes < endInMinutes) {
        currentCourse = course;
      } else if (currentTimeInMinutes < startInMinutes && nextCourse == null) {
        nextCourse = course;
      }
    }

    if (currentCourse != null) {
      state.time.value = -1;
      state.className.value = currentCourse.className;
      state.placeName.value = currentCourse.location;
    } else if (nextCourse != null) {
      final startDateTime = state.courseTimes[nextCourse.session - 1];

      final nextCourseStartHour = startDateTime.hour;
      final nextCourseStartMinute = startDateTime.minute;

      final nextCourseStartInMinutes =
          nextCourseStartHour * 60 + nextCourseStartMinute;

      final remainingMinutes = nextCourseStartInMinutes - currentTimeInMinutes;

      state.time.value = remainingMinutes;
      state.className.value = nextCourse.className;
      state.placeName.value = nextCourse.location;
    } else {
      state.time.value = 0;
      state.className.value = "今天没有课程";
      state.placeName.value = "";
    }
    WidgetLogic.updateWidget(
        state.className.value,
        state.time.value >= 0 ? "${formatTime(state.time.value)} 后上课" : "正在上课中",
        state.placeName.value.isEmpty ? "无" : state.placeName.value,
        state.time.value >= 0 ? "下一课程:" : "当前课程");
  }

  String formatTime(int minutes) {
    final hours = minutes ~/ 60; // 整小时
    final remainingMinutes = minutes % 60; // 剩余分钟
    if (hours > 0) {
      return "$hours小时$remainingMinutes分钟";
    } else {
      return "$remainingMinutes分钟";
    }
  }
}
