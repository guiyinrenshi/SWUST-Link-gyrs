import 'package:shared_preferences/shared_preferences.dart';


Future<int> loadFirstDayAndCalculateWeek() async {
  final prefs = await SharedPreferences.getInstance();
  final firstDayString = prefs.getString("firstDay");

  if (firstDayString != null && firstDayString.isNotEmpty) {
    try {
      // 解析第一天日期
      final firstDay = DateTime.parse(firstDayString);
      final today = DateTime.now();

      // 确保日期只比较到天，忽略时间部分
      final normalizedFirstDay = DateTime(firstDay.year, firstDay.month, firstDay.day);
      final normalizedToday = DateTime(today.year, today.month, today.day);

      // 获取第一天到今天的天数差
      final difference = normalizedToday.difference(normalizedFirstDay).inDays;

      if (difference < 0) {
        // 如果今天在第一天之前，返回第一周
        return 1;
      }

      // 获取第一天的周几 (1为周一，7为周日)
      final firstDayWeekday = normalizedFirstDay.weekday;

      // 计算第一周额外的天数
      final firstWeekExtraDays = firstDayWeekday - 1; // 第一周多出来的天数（从周一开始计）

      // 计算总天数（包含第一周的多余天数）
      final totalDaysWithExtra = difference + firstWeekExtraDays;

      // 计算第几周（向下取整）
      return (totalDaysWithExtra ~/ 7) + 1;
    } catch (e) {
      print("Invalid date format in SharedPreferences: $firstDayString");
      return 1;
    }
  }

  // 如果 SharedPreferences 中没有存储日期，默认返回第 1 周
  return 1;
}

