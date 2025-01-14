import 'package:shared_preferences/shared_preferences.dart';



Future<int> loadFirstDayAndCalculateWeek() async {
  final prefs = await SharedPreferences.getInstance();
  final firstDayString = prefs.getString("firstDay");

  if (firstDayString != null && firstDayString.isNotEmpty) {
    try {
      // 解析第一天日期
      final firstDay = DateTime.parse(firstDayString);
      final today = DateTime.now();

      // 获取第一天的周几 (0为周日，1为周一，以此类推)
      final firstDayWeekday = firstDay.weekday; // 1为周一，7为周日

      // 获取从第一天到今天的天数差
      final difference = today.difference(firstDay).inDays;

      // 计算当前为第几周
      // 如果第一天不是周一，第一周会包含这部分天数，因此 +1
      final firstWeekExtraDays = firstDayWeekday - 1; // 第一周多出来的天数
      final totalDaysWithExtra = difference + firstWeekExtraDays;

      return (totalDaysWithExtra ~/ 7) + 1; // 总天数除以7，向上取整
    } catch (e) {
      print("Invalid date format: $firstDayString");
    }
  }
  return 1;
}
