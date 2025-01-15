import 'package:html/parser.dart';
import 'package:logger/logger.dart';
import 'package:swust_link/common/entity/oa/course.dart';
import 'package:swust_link/spider/oa_auth.dart';

class UndergraduateClassTable {
  late OAAuth oa;
  late String username;
  late String password;

  UndergraduateClassTable({required this.username, required this.password}) {
    oa = OAAuth(
        service:
            "https://matrix.dean.swust.edu.cn/acadmicManager/index.cfm?event=studentPortal:DEFAULT_EVENT",
        username: username,
        password: password);
  }

  Future<bool> login() async {
    return await oa.login();
  }

  // Future<List<ClassInfo>> getClassTable() {
  //
  // }
  // Future<void> getClassTable() async {
  //
  //   Response response = await oa.dio.get("https://matrix.dean.swust.edu.cn/acadmicManager/index.cfm?event=chooseCourse:courseTable");
  //   Logger().i(response.data);
  //   List<List<String>> out = parseTable(response.data,tableSelector: "#choosenCourseTable" );
  //   Logger().i(out);
  // }

  Future<List<Course>> parseClassTable(String url) async {
    try {
      // 发起 GET 请求获取课程表 HTML
      final response = await oa.dio.get(url);
      if (response.statusCode != 200) {
        throw Exception("Failed to fetch class table, status code: ${response.statusCode}");
      }

      // 解析 HTML
      final document = parse(response.data);
      final table = document.querySelector("#choosenCourseTable tbody");
      if (table == null) throw Exception("Failed to locate course table");

      // 初始化结果列表
      List<Course> courses = [];
      final rows = table.querySelectorAll("tr");
      String? currentPeriod; // 上午/下午/晚上
      int currentSessionBase = 0; // 当前时间段的 session 基值
      Map<int, int> rowspanMap = {}; // 跟踪 rowSpan 的列映射

      for (var rowIndex = 0; rowIndex < rows.length; rowIndex++) {
        final row = rows[rowIndex];
        final cells = row.querySelectorAll("td");

        int colIndex = 0; // 当前列索引

        for (var cellIndex = 0; cellIndex < cells.length; cellIndex++) {
          // 跳过被 rowspan 占据的列
          while (rowspanMap.containsKey(colIndex) && rowspanMap[colIndex]! > 0) {
            rowspanMap[colIndex] = rowspanMap[colIndex]! - 1;
            colIndex++;
          }

          final cell = cells[cellIndex];

          // 如果是时间段单元格，设置当前时间段并初始化 session 基值
          if (cell.attributes.containsKey('rowspan') && colIndex == 0) {
            currentPeriod = cell.text.trim();
            if (currentPeriod == "上午") {
              currentSessionBase = 0; // 上午从 1 开始
            } else if (currentPeriod == "下午") {
              currentSessionBase = 2; // 下午从 3 开始
            } else if (currentPeriod == "晚上") {
              currentSessionBase = 4; // 晚上从 5 开始
            }
          }

          // 如果有 rowspan，记录其跨行信息
          if (cell.attributes.containsKey('rowspan')) {
            final rowspan = int.parse(cell.attributes['rowspan']!);
            rowspanMap[colIndex] = rowspan - 1;
          }

          // 计算 session
          int session = currentSessionBase + (rowIndex % 2) + 1;

          // 解析课程信息
          final lectures = cell.querySelectorAll(".lecture");
          for (var lecture in lectures) {
            final className = lecture.querySelector(".course")?.text.trim() ?? "未知课程";
            final teacher = lecture.querySelector(".teacher")?.text.trim() ?? "未知教师";
            final week = lecture.querySelector(".week")?.text.trim() ?? "";
            final startTime = week.split("-").first;
            final endTime = week.split("-").last.split("(").first;
            final location = lecture.querySelector(".place")?.text.trim() ?? "未知地点";

            courses.add(Course(
              className: className,
              teacher: teacher,
              location: location,
              startTime: startTime,
              endTime: endTime,
              weekDay: colIndex - 2 + 1, // 星期几，从 1 开始
              period: currentPeriod ?? "未知",
              session: session,
            ));
          }

          colIndex++; // 移动到下一个列索引
        }
      }
      Logger().i(courses);
      return courses;
    } catch (e) {
      print("Error parsing class table: $e");
      return [];
    }
  }




}


