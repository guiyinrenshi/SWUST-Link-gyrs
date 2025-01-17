class Course {
  final String className;
  final String teacher;
  final String location;
  final String startTime;
  final String endTime;
  final int weekDay;
  final String period; // 上午/下午/晚上
  final int session; // 第几讲

  Course({
    required this.className,
    required this.teacher,
    required this.location,
    required this.startTime,
    required this.endTime,
    required this.weekDay,
    required this.period,
    required this.session,
  });

  // JSON 转 Course 对象
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      className: json['className'] as String,
      teacher: json['teacher'] as String,
      location: json['location'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      weekDay: json['weekDay'] as int,
      period: json['period'] as String,
      session: json['session'] as int,
    );
  }

  // Course 对象转 JSON
  Map<String, dynamic> toJson() {
    return {
      'className': className,
      'teacher': teacher,
      'location': location,
      'startTime': startTime,
      'endTime': endTime,
      'weekDay': weekDay,
      'period': period,
      'session': session,
    };
  }

  @override
  String toString() {
    return 'Course(className: $className, teacher: $teacher, location: $location, '
        'startTime: $startTime, endTime: $endTime, weekDay: $weekDay, '
        'period: $period, session: $session)';
  }
}

class CourseTime {
  final int week; // 周次
  final int weekday; // 星期几 (1-7)
  final int startPeriod; // 起始节次
  final int endPeriod; // 结束节次

  CourseTime({
    required this.week,
    required this.weekday,
    required this.startPeriod,
    required this.endPeriod,
  });

  @override
  String toString() {
    return 'Week: $week, Weekday: $weekday, Start: $startPeriod, End: $endPeriod';
  }
}