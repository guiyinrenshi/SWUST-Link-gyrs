import 'package:get/get.dart';
import 'package:swust_link/common/entity/oa/course.dart';

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
      // final startTimeParts = course.period.split(":");
      final startDateTime = state.courseTimes[course.session - 1];
      // final startHour = int.parse(startTimeParts[0]);
      // final startMinute = int.parse(startTimeParts[1]);
      final startHour = startDateTime.hour;
      final startMinute = startDateTime.minute;
      final startInMinutes = startHour * 60 + startMinute;
      final endInMinutes = startInMinutes + state.classDuration;

      if (currentTimeInMinutes >= startInMinutes &&
          currentTimeInMinutes < endInMinutes) {
        // 当前时间在某一节课时间段内
        currentCourse = course;
      } else if (currentTimeInMinutes < startInMinutes && nextCourse == null) {
        // 找到下一节课
        nextCourse = course;
      }
    }

    if (currentCourse != null) {
      // 正在上课
      state.time.value = -1;
      state.className.value = currentCourse.className;
      state.teacherName.value = currentCourse.teacher;
      state.placeName.value = currentCourse.location;
    } else if (nextCourse != null) {
      // 下一节课
      // final nextCourseStartTimeParts = nextCourse.period.split(":");
      final startDateTime = state.courseTimes[nextCourse.session - 1];


      final nextCourseStartHour = startDateTime.hour;
      final nextCourseStartMinute = startDateTime.minute;

      final nextCourseStartInMinutes =
          nextCourseStartHour * 60 + nextCourseStartMinute;

      final remainingMinutes = nextCourseStartInMinutes - currentTimeInMinutes;

      state.time.value = remainingMinutes;
      state.className.value = nextCourse.className;
      state.teacherName.value = nextCourse.teacher;
      state.placeName.value = nextCourse.location;
    } else {
      // 今天没有课程
      state.time.value = 0;
      state.className.value = "今天没有课程";
      state.teacherName.value = "";
      state.placeName.value = "";
    }
  }

  String formatTime(int minutes) {
    final hours = minutes ~/ 60; // 整小时
    final remainingMinutes = minutes % 60; // 剩余分钟
    if (hours > 0) {
      return "$hours小时${remainingMinutes}分钟";
    } else {
      return "$remainingMinutes分钟";
    }
  }
}
