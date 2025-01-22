import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:swust_link/common/global.dart';
import 'package:swust_link/spider/oa_auth.dart';

import '../common/entity/oa/score.dart';

class ClassScore {
  final OAAuth matrixOa;

  ClassScore(this.matrixOa);

  Future<List<CourseScore>> getScoreList() async {
    final url =
        "https://matrix.dean.swust.edu.cn/acadmicManager/index.cfm?event=studentProfile:courseMark";
    final res = await matrixOa.dio.get(url);
    return extractCourses(res.data);
  }

  /// 获取当前元素的所有后续兄弟元素（仅元素节点）
  List<Element> nextElementSiblings(Element element) {
    final parent = element.parent;
    if (parent == null) return [];

    final siblings = parent.children;
    final currentIndex = siblings.indexOf(element);

    // 返回从当前节点之后的所有兄弟元素
    return siblings.sublist(currentIndex + 1);
  }

  /// 提取课程数据
  List<CourseScore> extractCourses(String htmlContent) {
    final document = parse(htmlContent);
    final tables = document.querySelectorAll('#Plan table.UItable'); // 查找课程表格
    List<CourseScore> courses = [];

    for (final table in tables) {
      // 提取学年信息
      final yearRow =
          table.querySelector('tr > td[colspan]')?.text.trim() ?? '';
      final yearMatch = RegExp(r'(\d{4}-\d{4})').firstMatch(yearRow);
      final year = yearMatch != null ? yearMatch.group(1) : '未知学年';

      // 提取学期和课程
      final semesterRows =
          table.querySelectorAll('tr.cellBorder > td[rowspan]');
      for (final semesterRow in semesterRows) {
        final semester = semesterRow.text.trim(); // 获取 "春" 或 "秋"
        final fullSemester = "$year-$semester"; // 组合为 "2023-2024-春"

        // 提取当前学期的课程行
        final parentRow = semesterRow.parent!;
        var currentRow = parentRow.nextElementSibling;
        while (currentRow != null) {
          final cells = currentRow.querySelectorAll('td');

          // 判断是否到了下一个学期的行或非课程行
          if (cells.isEmpty || cells.length < 7) {
            break; // 跳出当前学期的循环
          }

          // 提取课程信息
          final name = cells[0].text.trim();
          final courseCode = cells[1].querySelector('span')?.text.trim() ?? '';
          final credit = cells[2].querySelector('span')?.text.trim() ?? '';
          final courseNature = cells[3].text.trim();
          final examScore = cells[4].querySelector('span')?.text.trim() ?? '';
          final retakeScore = cells[5].querySelector('span')?.text.trim() ?? '';
          final gpa = cells[6].querySelector('span')?.text.trim() ?? '';

          // 确保该行确实是课程数据
          if (name != "课程" && courseNature != "课程性质") {
            courses.add(CourseScore(
              semester: fullSemester,
              name: name,
              courseCode: courseCode,
              credit: credit,
              courseNature: courseNature,
              examScore: examScore == ""
                  ? gpa.isNotEmpty
                      ? "通过"
                      : "不通过"
                  : examScore,
              retakeScore: retakeScore,
              gpa: gpa,
            ));
          }

          currentRow = currentRow.nextElementSibling;
        }
      }
    }

    var table = document.querySelector('#Common table.UItable'); // 定位表格

    if (table != null) {
      // 遍历所有课程行，跳过表头
      final rows = table.querySelectorAll('tr.cellBorder');
      for (final row in rows) {
        final cells = row.querySelectorAll('td');

        // 确保行包含足够的列数据
        if (cells.length >= 7) {
          final name = cells[1].text.trim(); // 课程名称
          final courseCode =
              cells[2].querySelector('span')?.text.trim() ?? ''; // 课程号
          final credit =
              cells[3].querySelector('span')?.text.trim() ?? ''; // 学分
          final examScore =
              cells[4].querySelector('span')?.text.trim() ?? ''; // 正考分数
          final retakeScore =
              cells[5].querySelector('span')?.text.trim() ?? ''; // 补考分数
          final gpa = cells[6].querySelector('span')?.text.trim() ?? ''; // 绩点

          courses.add(CourseScore(
            semester: "全校通选课",
            // 固定为全校通选课
            name: name,
            courseCode: courseCode,
            credit: credit,
            courseNature: "通选课",
            // 根据实际需要定义课程性质
            examScore: examScore,
            retakeScore: retakeScore,
            gpa: gpa,
          ));
        }
      }
    }

    table = document.querySelector('#Physical table.UItable'); // 定位表格

    if (table != null) {
      // 遍历所有课程行，跳过表头
      final rows = table.querySelectorAll('tr.cellBorder');
      for (final row in rows) {
        final cells = row.querySelectorAll('td');

        // 确保行包含足够的列数据
        if (cells.length >= 7) {
          final name = cells[1].text.trim(); // 课程名称
          final courseCode =
              cells[2].querySelector('span')?.text.trim() ?? ''; // 课程号
          final credit =
              cells[3].querySelector('span')?.text.trim() ?? ''; // 学分
          final examScore =
              cells[4].querySelector('span')?.text.trim() ?? ''; // 正考分数
          final retakeScore =
              cells[5].querySelector('span')?.text.trim() ?? ''; // 补考分数
          final gpa = cells[6].querySelector('span')?.text.trim() ?? ''; // 绩点

          courses.add(CourseScore(
            semester: "体育项目",
            // 固定为全校通选课
            name: name,
            courseCode: courseCode,
            credit: credit,
            courseNature: "体育项目",
            // 根据实际需要定义课程性质
            examScore: examScore,
            retakeScore: retakeScore,
            gpa: gpa,
          ));
        }
      }
    }
    return courses;
  }
}
