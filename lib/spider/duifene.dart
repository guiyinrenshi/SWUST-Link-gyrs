import 'dart:convert';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:logger/logger.dart';

class DuiFenE {
  late Dio dio;
  late String username;
  late String password;
  late Map<String, String> headers;
  late CookieJar cookieJar;

  DuiFenE({required this.username, required this.password}) {
    dio = Dio();
    cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));
    headers = {
      "accept": "application/json, text/javascript, */*; q=0.01",
      "accept-language": "zh-CN,zh;q=0.9",
      "cache-control": "no-cache",
      "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
      "origin": "https://www.duifene.com",
      "pragma": "no-cache",
      "priority": "u=1, i",
      "referer": "https://www.duifene.com/",
      "sec-ch-ua":
          "\"Chromium\";v=\"128\", \"Not;A=Brand\";v=\"24\", \"Google Chrome\";v=\"128\"",
      "sec-ch-ua-mobile": "?0",
      "sec-ch-ua-platform": "\"Windows\"",
      "sec-fetch-dest": "empty",
      "sec-fetch-mode": "cors",
      "sec-fetch-site": "same-origin",
      "user-agent":
          "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36",
      "x-requested-with": "XMLHttpRequest"
    };
    dio.options.headers.addAll(headers);
  }

  Future<bool> passwordLogin() async {
    String url = "https://www.duifene.com/AppCode/LoginInfo.ashx";
    var data = {
      "action": "login",
      "loginname": username,
      "password": password,
      "issave": "false",
    };
    try {
      var response = await dio.post(url, data: data);
      if (response.statusCode == 200) {
        Logger().i("登录成功！${response.data}");
        return true;
      } else {
        Logger().e("登录失败！${response.data}");
        return false;
      }
    } catch (e) {
      Logger().e("登录失败！$e");
      return false;
    }
  }

  List<Course> parseCourses(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Course>((json) => Course.fromJson(json)).toList();
  }

  Future<List<Course>?> getCourseInfo() async {
    String url = "https://www.duifene.com/_UserCenter/CourseInfo.ashx";
    var payload = {"action": "getstudentcourse", "classtypeid": 2};
    try {
      var response = await dio.post(url, data: payload);
      if (response.statusCode == 200) {
        Logger().d(response.data);
        Logger().i("获取课程成功！");
        return parseCourses(response.data);
      } else {
        Logger().d(response.data);
        Logger().e("获取课程失败！");
        return null;
      }
    } catch (e) {
      Logger().e("获取课程失败！$e");
    }
    return null;
  }

  Future<List<Paper>> getAllPager() async {
    List<Course>? courses = await getCourseInfo();
    List<Paper>? papers = [];
    if (courses != null) {
      for (Course course in courses) {
        List<Paper>? paper = await getPaperList(course.courseID);
        if (paper != null) {
          papers.addAll(paper);
        }
      }
    } else {
      Logger().i("没有课程信息");
    }
    return papers;
  }

  Future<bool> getCourseMoreInfo(String courseId) async {
    String url = "https://www.duifene.com/_UserCenter/CourseInfo.ashx";
    var payload = {
      "action": "getcoursemodule",
      "classtypeid": 2,
      "courseid": courseId
    };
    try {
      var response = await dio.post(url, data: payload);
      if (response.statusCode == 200) {
        Logger().d(response.data);
        Logger().i("获取课程信息成功！");
        return true;
      } else {
        Logger().d(response.data);
        Logger().e("获取课程信息失败！");
        return false;
      }
    } catch (e) {
      Logger().e("获取课程信息失败！$e");
      return false;
    }
  }

  Future<String?> joinClass(String classId) async {
    String url = "https://www.duifene.com/_UserCenter/CourseInfo.ashx";
    var payload = {"action": "joinclassbyclasscode", "classcode": classId};
    try {
      var response = await dio.post(url,
          data: payload, options: Options(responseType: ResponseType.plain));

      final parsed = json.decode(response.data);
      return parsed['msg'] as String?;
    } catch (e) {
      Logger().e("加入班级失败！$e");
    }
    return "加入班级失败";
  }

  Future<List<Paper>?> getPaperList(String courseID) async {
    String url = "https://www.duifene.com/_Paper/StudentPaper.ashx";
    var payload = {"action": "datalist", "CourseID": courseID};
    try {
      var response = await dio.post(url,
          data: payload, options: Options(responseType: ResponseType.plain));
      final parsed = json.decode(response.data);
      if (parsed['msg'] == '1') {
        final List<dynamic> papersJson = parsed['jsontb1'];
        return papersJson.map<Paper>((json) => Paper.fromJson(json)).toList();
      } else {
        Logger().i("暂无数据：${parsed['msgbox']}");
        return null;
      }
    } catch (e) {
      Logger().e("获取练习列表失败！$e");
      return null;
    }
  }
}

class Course {
  final String termID;
  final String termName;
  final String termStatus;
  final String courseID;
  final String courseName;
  final String backgroundColor;
  final String color;
  final String isCanel;
  final String createrID;
  final String createrDate;
  final String updaterDate;
  final String tClassID;
  final String className;

  Course({
    required this.termID,
    required this.termName,
    required this.termStatus,
    required this.courseID,
    required this.courseName,
    required this.backgroundColor,
    required this.color,
    required this.isCanel,
    required this.createrID,
    required this.createrDate,
    required this.updaterDate,
    required this.tClassID,
    required this.className,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    String backgroundColor =
        json['BackgroundColor'] == '#fff' ? '#e0e0e0' : json['BackgroundColor'];
    String color = json['Color'] == '#fff' ? '#e0e0e0' : json['Color'];

    return Course(
      termID: json['TermID'],
      termName: json['TermName'],
      termStatus: json['TermStatus'],
      courseID: json['CourseID'],
      courseName: json['CourseName'],
      backgroundColor: backgroundColor,
      color: color,
      isCanel: json['IsCanel'],
      createrID: json['CreaterID'],
      createrDate: json['CreaterDate'],
      updaterDate: json['UpdaterDate'],
      tClassID: json['TClassID'],
      className: json['ClassName'],
    );
  }
}

class Paper {
  final String histPaperID;
  final String name;
  final String createDate;
  final String endDate;
  final String myScore;
  final String myDoneDate;

  Paper({
    required this.histPaperID,
    required this.name,
    required this.createDate,
    required this.endDate,
    required this.myScore,
    required this.myDoneDate,
  });

  factory Paper.fromJson(Map<String, dynamic> json) {
    return Paper(
      histPaperID: json['HistPaperID'],
      name: json['Name'],
      createDate: json['CreateDate'],
      endDate: json['EndDate'],
      myScore: json['MyScore'],
      myDoneDate: json['MyDoneDate'],
    );
  }
}
