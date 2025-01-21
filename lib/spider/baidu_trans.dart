import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:crypto/crypto.dart';

class BaiduTrans {
  late String appID;
  late String key;
  late String errorMsg;

  BaiduTrans({required this.appID, required this.key});

  Future<bool> connect() async {
    String salt = _generateSalt(10);
    String query = 'abandon';
    String sign = generateSign(query, salt);
    String url = 'http://api.fanyi.baidu.com/api/trans/vip/translate'
        '?q=${Uri.encodeComponent(query)}'
        '&from=en'
        '&to=zh'
        '&appid=$appID'
        '&salt=$salt'
        '&sign=$sign';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Logger().i("获取到返回信息${response.body}");
      var responseBody = json.decode(response.body);
      if (!responseBody.containsKey("error_code")) {
        return true;
      } else {
        if (responseBody["error_code"] == "52001") {
          errorMsg = "请求超时，检查请求query是否超长，以及原文或译文参数是否支持";
        } else if (responseBody["error_code"] == "52002") {
          errorMsg = "系统错误，请重试";
        } else if (responseBody["error_code"] == "52003") {
          errorMsg = "未授权用户，请检查您的appID是否正确，或者服务是否开通";
        } else if (responseBody["error_code"] == "54000") {
          errorMsg = "必填参数为空，请检查是否少传参数";
        } else if (responseBody["error_code"] == "54001") {
          errorMsg = "key错误，请检查您的key是否正确";
        } else if (responseBody["error_code"] == "58000") {
          errorMsg = "客户端IP非法，请检查个人资料里填写的IP地址是否正确，可前往开发者信息-基本信息修改";
        } else if (responseBody["error_code"] == "54003") {
          errorMsg = "访问频率受限，请降低您的调用频率，或进行身份认证后切换为高级版";
        } else if (responseBody["error_code"] == "54004") {
          errorMsg = "账户余额不足，请前往管理控制台为账户充值";
        } else if (responseBody["error_code"] == "54005") {
          errorMsg = "长query请求频繁，请降低长query的发送频率，3s后再试";
        } else if (responseBody["error_code"] == "58001") {
          errorMsg = "译文语言方向不支持，请检查译文语言是否在语言列表里";
        } else {
          Logger().i("翻译结果：${responseBody["trans_result"]["dst"]}");
        }
        return false;
      }
    } else {
      Logger().e("未能收到服务器响应，请检查网络连接");
      return false;
    }
  }

  String getErrorMsg(){
    return errorMsg;
  }
  String _generateSalt(int length) {
    const chars = '0123456789';
    Random random = Random();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
  }

  String generateSign(String query, String salt) {
    String str = appID + query + salt + key;
    String data = md5.convert(utf8.encode(str)).toString();
    return data;
  }
}