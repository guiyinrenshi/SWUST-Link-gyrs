import 'dart:convert';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:html/parser.dart';
import 'package:logger/logger.dart';
import 'package:swust_link/common/entity/duifene/course.dart';
import 'package:swust_link/common/entity/duifene/paper.dart';

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
    print(password);
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

  Future<String> signIn(String checkincode) async {
    String url = "https://www.duifene.com/_CheckIn/PC/StudentCheckIn.aspx";
    var stuIdInfoRaw = await dio.get(url);
    Logger().i(stuIdInfoRaw);
    var document = parse(stuIdInfoRaw.data);
    String? stuId = document.querySelector("#HFStudentID")!.attributes['value'];
    String signUrl = "https://www.duifene.com/_CheckIn/CheckIn.ashx";
    var payload = {
      "action": "studentcheckin",
      "studentid": stuId,
      "checkincode": checkincode
    };
    Logger().i(payload);
    try {
      var res = await dio.post(signUrl, data: FormData.fromMap(payload));
      if (res.data is String) {
        // 如果返回的数据是字符串，需要先解析为 Map
        var data = jsonDecode(res.data) as Map<String, dynamic>;
        return data['msgbox'] ?? "未知错误";
      } else if (res.data is Map<String, dynamic>) {
        // 如果返回的数据已经是 Map，则直接访问
        return res.data['msgbox'] ?? "未知错误";
      } else {
        return "签到失败: 返回数据格式不支持";
      }
    } catch (e) {
      return "签到失败: ${e.toString()}";
    }
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
