import 'package:get/get.dart';
import 'package:swust_link/common/entity/oa/course.dart';
import '../../common/widget/widget_logic.dart';
import 'class_card_state.dart';

class ClassCardLogic extends GetxController {
  final ClassCardState state = ClassCardState();

  @override
  void onInit() {
    super.onInit();
    updateCourseState();
    ever(state.currentTime, (_) => updateCourseState());
    state.currentTime.value = DateTime.now();
    updateEveryMinute();
  }

  void updateEveryMinute() {
    Future.delayed(Duration(minutes: 1), () {
      state.currentTime.value = DateTime.now();
      updateEveryMinute();
    });
  }

  void updateCourseState() {
    final now = state.currentTime.value;
    final currentTimeInMinutes = now.hour * 60 + now.minute;

    Course? currentCourse;
    Course? nextCourse;

    for (var course in state.todayCourseList) {
      final startDateTime = state.courseTimes[course.session - 1];
      final startInMinutes = startDateTime.hour * 60 + startDateTime.minute;
      final endInMinutes = startInMinutes + state.classDuration;

      if (currentTimeInMinutes >= startInMinutes && currentTimeInMinutes < endInMinutes) {
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
      final nextCourseStartInMinutes = startDateTime.hour * 60 + startDateTime.minute;
      final remainingMinutes = nextCourseStartInMinutes - currentTimeInMinutes;

      state.time.value = remainingMinutes;
      state.className.value = nextCourse.className;
      state.placeName.value = nextCourse.location;
    } else {
      state.time.value = 0;
      state.className.value = "今天没有课程";
      state.placeName.value = "";
    }

    _updateWidget();
  }

  void _updateWidget() {
    WidgetLogic.updateWidget(
      state.className.value,
      state.time.value >= 0 ? "${formatTime(state.time.value)} 后上课" : "正在上课中",
      state.placeName.value.isEmpty ? "无" : state.placeName.value,
      state.time.value >= 0 ? "下一课程:" : "当前课程",
    );
  }

  String formatTime(int minutes) {
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;
    return hours > 0 ? "$hours小时$remainingMinutes分钟" : "$remainingMinutes分钟";
  }
}
