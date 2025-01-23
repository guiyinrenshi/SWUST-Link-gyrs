import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gbk_codec/gbk_codec.dart';
import 'package:html/parser.dart';
import 'package:logger/logger.dart';
import 'package:swust_link/common/entity/oa/leave_form.dart';
import 'package:swust_link/common/entity/oa/leave_info.dart';
import 'package:swust_link/spider/oa_auth.dart';
import 'package:swust_link/utils/gbk_url.dart';

class XscLeave {
  late final OAAuth oa;

  XscLeave(this.oa);

  Future<LeaveInfoRecord> getAllLeave(int page) async {
    final url =
        "http://xsc.swust.edu.cn/Sys/SystemForm/Leave/StuAllLeaveManage.aspx";
    final res = await oa.dio.get(url,
        options: Options(headers: {
          "Accept":
              "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
          "Accept-Language": "zh-CN,zh;q=0.9",
          "Connection": "keep-alive",
          "Referer": "http://xsc.swust.edu.cn/Sys/SystemForm/MainDocment.aspx",
          "Upgrade-Insecure-Requests": "1",
          "User-Agent":
              "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36"
        }, responseDecoder: gbkDecoder));
    return LeaveInfoRecord(res.data);
  }

  Future<LeaveApplication> getLeaveHiddenParams(LeaveApplication la) async {
    final url =
        "http://xsc.swust.edu.cn/Sys/SystemForm/Leave/StuAllLeaveManage_Edit.aspx?Status=Add";
    final res = await oa.dio.get(url,
        options: Options(headers: {
          "Accept":
              "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
          "Accept-Language": "zh-CN,zh;q=0.9",
          "Connection": "keep-alive",
          "Referer": "http://xsc.swust.edu.cn/Sys/SystemForm/MainDocment.aspx",
          "Upgrade-Insecure-Requests": "1",
          "User-Agent":
              "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36"
        }));
    final document = parse(res.data);
    la.eventTarget = "Save";
    la.viewState =
        document.getElementById("__VIEWSTATE")!.attributes['value']!.trim();
    la.viewStateGenerator = document
        .getElementById("__VIEWSTATEGENERATOR")!
        .attributes['value']!
        .trim();
    la.hidden1 = document
        .getElementById("AllLeave1_Hidden1")!
        .attributes['value']!
        .trim();
    return la;
  }

  String gbkDecoder(List<int> responseBytes, RequestOptions options,
      ResponseBody responseBody) {
    return gbk_bytes.decode(responseBytes);
  }

  Future<List<int>> gbkRequestEncoder(
      String data, RequestOptions options) async {
    Logger().i(data);
    Logger().i(gbk.encode(data));
    return gbk.encode(data);
  }

  /// 手动构建表单数据并编码为 GBK
  Future<String> buildFormData(Map<String, dynamic> data) async {
    final buffer = StringBuffer();

    data.forEach((key, value) {
      if (buffer.isNotEmpty) {
        buffer.write("&");
      }

      // // 编码 Key
      // final encodedKey = gbk.encode(key).map((e) => '%${e.toRadixString(16).toUpperCase()}').join();
      final encodedKey = Uri.encodeComponent(key);
      //
      // // 编码 Value
      String encodedValue;
      if (value is String && RegExp(r"[\u4e00-\u9fa5]").hasMatch(value)) {
        // 如果包含中文，使用 GBK 编码
        encodedValue = UrlEncode.getInstance()!.encode(value);
      } else {
        // 如果不包含中文，使用默认 URL 编码
        encodedValue = Uri.encodeComponent(value.toString());
      }
      // final encodedValue = Uri.encodeComponent(value.toString());
      buffer.write("$encodedKey=$encodedValue");
    });

    return buffer.toString();
  }

  Future<String> submitLeaveApplication(LeaveApplication la) async {
    final url =
        "http://xsc.swust.edu.cn/Sys/SystemForm/Leave/StuAllLeaveManage_Edit.aspx?Status=Add";
    var formData = await la.toFormData();
    // var data = FormData.fromMap(formData);
    // // 手动编码
    final encodedData = await buildFormData(formData);
    final res = await oa.dio.post(url,
        options: Options(
            headers: {
              "Accept":
                  "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
              "Accept-Language": "zh-CN,zh;q=0.9",
              "Cache-Control": "max-age=0",
              "Content-Type": "application/x-www-form-urlencoded",
              "Origin": "http://xsc.swust.edu.cn",
              "Proxy-Connection": "keep-alive",
              "Referer":
                  "http://xsc.swust.edu.cn/Sys/SystemForm/Leave/StuAllLeaveManage_Edit.aspx?Status=Add",
              "Upgrade-Insecure-Requests": "1",
              "User-Agent":
                  "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36"
            },
            contentType: Headers.formUrlEncodedContentType,
            responseDecoder: gbkDecoder),
        data: encodedData);

    final regex = RegExp(r"<script>alert\('(.+?)'\);");
    final match = regex.firstMatch(res.data);
    if (match != null && match.groupCount > 0) {
      return match.group(1)!; // 获取正则匹配到的第一个捕获组内容
    }
    return "服务器错误";
  }
}
