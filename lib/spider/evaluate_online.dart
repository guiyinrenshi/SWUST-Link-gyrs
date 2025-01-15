import 'dart:convert';

import 'package:html/parser.dart';
import 'package:logger/logger.dart';
import 'package:swust_link/common/entity/oa/evaluation_paper.dart';
import 'package:swust_link/spider/oa_auth.dart';
import 'package:dio/dio.dart';

class EvaluateOnline {
  late OAAuth oa;

  EvaluateOnline(username, password) {
    oa = OAAuth(
        service:
            "https://matrix.dean.swust.edu.cn/acadmicManager/index.cfm?event=studentPortal:DEFAULT_EVENT",
        username: username,
        password: password);
  }

  Future<bool> login() async {
    return await oa.login();
  }

  Future<List<EvaluationPaper>> getEvaluationPaperList() async {
    final url =
        'https://matrix.dean.swust.edu.cn/acadmicManager/index.cfm?event=evaluateOnline:DEFAULT_EVENT';
    var res = await oa.dio.get(url);
    var document = parse(res.data);
    var evaluationList = <EvaluationPaper>[];
    final baseurl = "https://matrix.dean.swust.edu.cn/acadmicManager/";
    var evaluationRawData = document.querySelectorAll(".editRows");

    for (var item in evaluationRawData) {
      final tds = item.querySelectorAll("td");
      try {
        String info = tds[2].text.trim().replaceAll(" ", "");

        evaluationList.add(EvaluationPaper(
            college: tds[1].text.trim(),
            course: info.split("-")[0],
            teacher: info.split("-")[1],
            url: baseurl + item.querySelector(".info")!.attributes['href']!));
      } catch (e) {
        continue;
      }
    }
    Logger().i(evaluationList);
    return evaluationList;
  }

  Future<Map<dynamic, dynamic>> parseEvaluation(
      Map<String, dynamic> data, int value) async {
    final url = data['url'];
    var res = await oa.dio.get(url);
    var document = parse(res.data);

    var scc =
        document.querySelector("input[name='SCC']")?.attributes['value'] ?? '';
    var stage =
        document.querySelector("input[name='Stage']")?.attributes['value'] ??
            '';
    var mode =
        document.querySelector("input[name='Mode']")?.attributes['value'] ?? '';
    var teacherId = document
            .querySelector("input[name='TeacherID']")
            ?.attributes['value'] ??
        '';
    var courseId =
        document.querySelector("input[name='CourseID']")?.attributes['value'] ??
            '';
    var title =
        document.querySelector("input[name='Title']")?.attributes['value'] ??
            '';
    var tid =
        document.querySelector("input[name='TID']")?.attributes['value'] ?? '';
    var tsk =
        document.querySelector("input[name='TSK']")?.attributes['value'] ?? '';

    var courseInfo = {
      "Mode": mode,
      "Stage": stage,
      "TeacherID": teacherId,
      "CourseID": courseId,
      "Title": title,
      "TID": tid,
      "SCC": scc,
      "TSK": tsk
    };

    var rawLinks =
        document.querySelectorAll(".cellBorder a[data-opt='$value']");
    var outData = [];

    for (var link in rawLinks) {
      var jsCode =
          link.attributes['href']?.replaceAll(" ", "").replaceAll("');", "") ??
              '';
      var chooseData = jsCode.split("postQuota('")[1].split("','");
      outData.add({
        "TAG": chooseData[0],
        "OPT": value,
        "ST": chooseData[2],
        "SCC": scc,
        "seed": (DateTime.now().millisecondsSinceEpoch),
        "data": data
      });
    }

    return {"courseInfo": courseInfo, "opts": outData};
  }

  Future<void> evaluateOption(Map<String, dynamic> option) async {
    final url =
        "https://matrix.dean.swust.edu.cn/acadmicManager/index.cfm?event=evaluateOnline:apiPostQuota";

    Logger().i(option);
    var response = await oa.dio.post(url,
        data: FormData.fromMap(option),
        options: Options(headers: {
          "accept":
              "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
          "accept-language": "zh-CN,zh;q=0.9",
          "cache-control": "max-age=0",
          "content-type": "application/x-www-form-urlencoded",
          "origin": "https://matrix.dean.swust.edu.cn",
          "priority": "u=0, i",
          "referer":
              "https://matrix.dean.swust.edu.cn/acadmicManager/index.cfm?event=evaluateOnline:evaluateResponse&ES=01&SCC=5120234012%2C117178%2C241P&ST=3DE3992A0817B87015450F5BD0448850724A0BEFD792646B0EC8439C2079B21A3356946B747E6DCECD07490B48AC3E0C&TSK=241%2C117178%2C002&TT=P",
          "sec-ch-ua":
              "\"Google Chrome\";v=\"131\", \"Chromium\";v=\"131\", \"Not_A Brand\";v=\"24\"",
          "sec-ch-ua-mobile": "?0",
          "sec-ch-ua-platform": "\"Windows\"",
          "sec-fetch-dest": "document",
          "sec-fetch-mode": "navigate",
          "sec-fetch-site": "same-origin",
          "sec-fetch-user": "?1",
          "upgrade-insecure-requests": "1",
          "user-agent":
              "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36"
        }));
    var resultString = response.data; // 返回的字符串
    try {
      var result = jsonDecode(resultString); // 解析为 Map
      if (result['success'] == true) {
        print("选择 ${option['data']['class']} 选项 ${option['OPT']} 成功");
      } else {
        print("选择 ${option['data']['class']} 选项失败");
      }
    } catch (e) {
      print("解析结果时发生错误: $e");
    }
  }

  Future<void> submitEvaluation(Map<String, dynamic> courseInfo) async {
    final url = "https://matrix.dean.swust.edu.cn/acadmicManager/index.cfm";
    var params = {"event": "evaluateOnline:evaluateResponseDo"};
    Logger().i(courseInfo);
    var response =
        await oa.dio.post(url, data: FormData.fromMap(courseInfo), queryParameters: params,options: Options(
          headers:  {
            "accept":
            "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
            "accept-language": "zh-CN,zh;q=0.9",
            "cache-control": "max-age=0",
            "content-type": "application/x-www-form-urlencoded",
            "origin": "https://matrix.dean.swust.edu.cn",
            "priority": "u=0, i",
            "referer":
            "https://matrix.dean.swust.edu.cn/acadmicManager/index.cfm?event=evaluateOnline:evaluateResponse&ES=01&SCC=5120234012%2C117178%2C241P&ST=3DE3992A0817B87015450F5BD0448850724A0BEFD792646B0EC8439C2079B21A3356946B747E6DCECD07490B48AC3E0C&TSK=241%2C117178%2C002&TT=P",
            "sec-ch-ua":
            "\"Google Chrome\";v=\"131\", \"Chromium\";v=\"131\", \"Not_A Brand\";v=\"24\"",
            "sec-ch-ua-mobile": "?0",
            "sec-ch-ua-platform": "\"Windows\"",
            "sec-fetch-dest": "document",
            "sec-fetch-mode": "navigate",
            "sec-fetch-site": "same-origin",
            "sec-fetch-user": "?1",
            "upgrade-insecure-requests": "1",
            "user-agent":
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36"
          },
          validateStatus: (status) {
            // 允许 302 状态码
            return status != null && (status >= 200 && status < 300 || status == 302);
          },
        ));

    if (response.statusCode == 200) {
      print("${courseInfo['Title']} 评价提交成功！");
    } else {
      print("${courseInfo['Title']} 评价提交失败！");
    }
  }

  Future<void> evaluateOne(
      Map<String, dynamic> evaluation, String courseComment, int value) async {
    var parsedData = await parseEvaluation(evaluation, value);
    var courseInfo = parsedData['courseInfo'];
    var opts = parsedData['opts'];

    courseInfo['CourseComment'] = courseComment;

    for (var opt in opts) {
      // try{
      await evaluateOption(opt);
      // } catch(e){
      //   continue;
      // }
    }

    await submitEvaluation(courseInfo);
  }

  Future<void> evaluate({String courseComment = "无", int value = 1}) async {
    var evaluationList = await getEvaluationPaperList();

    for (var evaluation in evaluationList) {
      await evaluateOne(evaluation.toJson(), courseComment, value);
    }
  }
}
