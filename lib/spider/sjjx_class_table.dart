import 'package:dio/dio.dart';
import 'package:get/get.dart' as g;
import 'package:get/get_core/src/get_main.dart';

import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:logger/logger.dart';
import 'package:swust_link/common/entity/sjjx/course_frame.dart';
import 'package:swust_link/common/global.dart';

import '../common/entity/oa/course.dart';
import 'oa_auth.dart';

class SJJXTable {
  SJJXTable(this.sjjxOa);

  late OAAuth sjjxOa;

  CourseTime parseTimeInfo(String timeInfo) {
    // 提取周次
    final weekMatch = RegExp(r'(\d+)周').firstMatch(timeInfo);
    int week = weekMatch != null ? int.parse(weekMatch.group(1)!) : 0;

    // 提取星期
    final weekdayMap = {
      '一': 1,
      '二': 2,
      '三': 3,
      '四': 4,
      '五': 5,
      '六': 6,
      '日': 7,
    };
    final weekdayMatch = RegExp(r'星期([一二三四五六日])').firstMatch(timeInfo);
    int weekday =
        weekdayMatch != null ? weekdayMap[weekdayMatch.group(1)!]! : 0;

    // 提取节次范围
    final periodMatch = RegExp(r'(\d+)-(\d+)节').firstMatch(timeInfo);
    int startPeriod =
        periodMatch != null ? int.parse(periodMatch.group(1)!) : 0;
    int endPeriod = periodMatch != null ? int.parse(periodMatch.group(2)!) : 0;

    return CourseTime(
      week: week,
      weekday: weekday,
      startPeriod: startPeriod,
      endPeriod: endPeriod,
    );
  }

  int parseTotalPages(String htmlContent) {
    Document document = parse(htmlContent);
    Element? pageInfo = document.querySelector("#myPage p");
    if (pageInfo != null) {
      final match = RegExp(r'共\s*(\d+)\s*页').firstMatch(pageInfo.text);
      if (match != null) {
        return int.parse(match.group(1)!);
      }
    }
    return 1; // 如果解析不到总页数，返回 1
  }

  Future<String> getInfo(pageNum) async {
    var res = await sjjxOa.dio.get(
      'https://sjjx.dean.swust.edu.cn/teachn/teachnAction/index.action?page.pageNum=$pageNum',
      options: Options(
        headers: {
          'accept':
              'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7',
          'accept-language': 'zh-CN,zh;q=0.9',
          'priority': 'u=0, i',
          'referer': 'https://sjjx.dean.swust.edu.cn/aexp/stuLeft.jsp',
          'sec-ch-ua':
              '"Google Chrome";v="131", "Chromium";v="131", "Not_A Brand";v="24"',
          'sec-ch-ua-mobile': '?0',
          'sec-ch-ua-platform': '"Windows"',
          'sec-fetch-dest': 'iframe',
          'sec-fetch-mode': 'navigate',
          'sec-fetch-site': 'same-origin',
          'sec-fetch-user': '?1',
          'upgrade-insecure-requests': '1',
          'user-agent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36',
        },
      ),
    );
    Logger().i(res.statusCode);
    return res.data;
  }

  List<Course> parseList(String data) {
    Document document = parse(data);
    List<Course> courses = [];

    List<Element> rows = document.querySelectorAll("table.tablelist tbody tr");

    for (var row in rows) {
      List<Element> columns = row.querySelectorAll("td");
      if (columns.length >= 5) {
        String courseName = columns[0].text.trim();
        String projectName = columns[1].text.trim();
        String classTime = columns[2].text.trim();
        String classLocation = columns[3].text.trim();
        String teacher = columns[4].text.trim();

        CourseTime courseTime = parseTimeInfo(classTime);

        Map<int, String> periodMapping = {
          1: "上午",
          2: "上午",
          3: "下午",
          4: "下午",
          5: "晚上",
          6: "晚上",
        };

        for (int session = (courseTime.startPeriod / 2).ceil();
            session <= (courseTime.endPeriod / 2).ceil();
            session++) {
          String period = periodMapping[session] ?? "未知";
          Course course = Course(
            className: "$courseName - $projectName",
            teacher: teacher,
            location: classLocation,
            startTime: courseTime.week.toString(),
            endTime: courseTime.week.toString(),
            weekDay: courseTime.weekday,
            period: period,
            session: session,
          );
          courses.add(course);
        }
      }
    }
    Logger().i(courses);
    return courses;
  }

  Future<List<Course>> getCourseList() async {
    var data = await getInfo(1);
    List<Course> courses = [];
    int page = parseTotalPages(data);
    courses.addAll(parseList(data));
    if (page > 1) {
      for (int i = 2; i <= page; i++) {
        var data = await getInfo(i);
        courses.addAll(parseList(data));
      }
    }
    return courses;
  }

  Future<List<CourseFrame>> getCourseFrameList() async {
    await sjjxOa.dio.get(
      'https://sjjx.dean.swust.edu.cn/teachn/teachnAction/index.action',
      options: Options(
        headers: {
          "accept":
              "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
          "accept-language": "zh-CN,zh;q=0.9",
          "priority": "u=0, i",
          "referer":
              "https://sjjx.dean.swust.edu.cn/teachn/teachnAction/selCourse.action",
          "sec-ch-ua":
              "\"Not(A:Brand\";v=\"99\", \"Google Chrome\";v=\"133\", \"Chromium\";v=\"133\"",
          "sec-ch-ua-mobile": "?0",
          "sec-ch-ua-platform": "\"Windows\"",
          "sec-fetch-dest": "iframe",
          "sec-fetch-mode": "navigate",
          "sec-fetch-site": "same-origin",
          "upgrade-insecure-requests": "1",
          "user-agent":
              "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"
        },
      ),
    );
    var res = await sjjxOa.dio.get(
      'https://sjjx.dean.swust.edu.cn/teachn/teachnAction/teachn/teachnAction/courseFrame.action',
      options: Options(
        headers: {
          "accept":
              "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
          "accept-language": "zh-CN,zh;q=0.9",
          "priority": "u=0, i",
          "referer":
              "https://sjjx.dean.swust.edu.cn/teachn/teachnAction/selCourse.action",
          "sec-ch-ua":
              "\"Not(A:Brand\";v=\"99\", \"Google Chrome\";v=\"133\", \"Chromium\";v=\"133\"",
          "sec-ch-ua-mobile": "?0",
          "sec-ch-ua-platform": "\"Windows\"",
          "sec-fetch-dest": "iframe",
          "sec-fetch-mode": "navigate",
          "sec-fetch-site": "same-origin",
          "upgrade-insecure-requests": "1",
          "user-agent":
              "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"
        },
      ),
    );

    Logger().i(res.data);
    return CourseFrame.fromHtml(res.data);
  }

  Future<List<Experiment>> getExperimentList(id, exp) async {
    var res = await sjjxOa.dio.get(
      'https://sjjx.dean.swust.edu.cn/teachn/teachnAction/expFrame.action?expid=$exp&week=&day=&teach_course_code=$id',
      options: Options(
        headers: {
          "accept":
              "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
          "accept-language": "zh-CN,zh;q=0.9",
          "priority": "u=0, i",
          "referer":
              "https://sjjx.dean.swust.edu.cn/teachn/teachnAction/selCourse.action",
          "sec-ch-ua":
              "\"Not(A:Brand\";v=\"99\", \"Google Chrome\";v=\"133\", \"Chromium\";v=\"133\"",
          "sec-ch-ua-mobile": "?0",
          "sec-ch-ua-platform": "\"Windows\"",
          "sec-fetch-dest": "iframe",
          "sec-fetch-mode": "navigate",
          "sec-fetch-site": "same-origin",
          "upgrade-insecure-requests": "1",
          "user-agent":
              "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"
        },
      ),
    );
    return Experiment.fromHtml(res.data);
  }

  Future<List<ExperimentProject>> getCourseProject(id) async {
    var res = await sjjxOa.dio.get(
      'https://sjjx.dean.swust.edu.cn/teachn/teachnAction/expFrame.action?teach_course_code=$id',
      options: Options(
        headers: {
          "accept":
              "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
          "accept-language": "zh-CN,zh;q=0.9",
          "priority": "u=0, i",
          "referer":
              "https://sjjx.dean.swust.edu.cn/teachn/teachnAction/selCourse.action",
          "sec-ch-ua":
              "\"Not(A:Brand\";v=\"99\", \"Google Chrome\";v=\"133\", \"Chromium\";v=\"133\"",
          "sec-ch-ua-mobile": "?0",
          "sec-ch-ua-platform": "\"Windows\"",
          "sec-fetch-dest": "iframe",
          "sec-fetch-mode": "navigate",
          "sec-fetch-site": "same-origin",
          "upgrade-insecure-requests": "1",
          "user-agent":
              "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"
        },
      ),
    );
    Logger().i(res.data);
    return ExperimentProject.fromHtml(res.data);
  }

  Future<String> selectClass(id, cId) async {
    var data = {"ids": id, "teachCourseCode": cId, "isPackage": 0};
    var res = await sjjxOa.dio.post(
        'https://sjjx.dean.swust.edu.cn/teachn/teachnAction/bookFram.action',
        options: Options(
          headers: {
            "accept":
                "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
            "accept-language": "zh-CN,zh;q=0.9",
            "priority": "u=0, i",
            "referer":
                "https://sjjx.dean.swust.edu.cn/teachn/teachnAction/selCourse.action",
            "sec-ch-ua":
                "\"Not(A:Brand\";v=\"99\", \"Google Chrome\";v=\"133\", \"Chromium\";v=\"133\"",
            "sec-ch-ua-mobile": "?0",
            "sec-ch-ua-platform": "\"Windows\"",
            "sec-fetch-dest": "iframe",
            "sec-fetch-mode": "navigate",
            "sec-fetch-site": "same-origin",
            "upgrade-insecure-requests": "1",
            "user-agent":
                "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"
          },
        ),
        data: FormData.fromMap(data));
    var messageMatch =
        RegExp(r"alert\('(.+?)'\);").firstMatch(res.data)?.group(1) ?? "失败";
    Logger().i(res.data);
    return messageMatch;
  }

  static SJJXTable? sjjxTable;

  static Future<SJJXTable?> getInstance() async {
    if (sjjxTable == null) {
      String? username = Global.prefs.getString("0username");
      String? password = Global.prefs.getString("0password");
      if (username != null && password != null) {
        var sjjxOa = OAAuth(
            service: "https://sjjx.dean.swust.edu.cn/swust/",
            username: username,
            password: password);
        if (await sjjxOa.login()) {
          sjjxTable = SJJXTable(sjjxOa);
        } else {
          g.Get.snackbar("登录失效", "请尝试刷新或检查账号密码是否正确!");
        }
      }
    }
    return sjjxTable;
  }
}
