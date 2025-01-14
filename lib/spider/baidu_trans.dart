import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:crypto/crypto.dart';

class BaiduTrans {
  late String appID;
  late String key;

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
          Logger().e(
              "请求超时，检查请求query是否超长，以及原文或译文参数是否支持");
        } else if (responseBody["error_code"] == "52002") {
          Logger().e("系统错误，请重试");
        } else if (responseBody["error_code"] == "52003") {
          Logger().e("未授权用户，请检查您的appID是否正确，或者服务是否开通");
        } else if (responseBody["error_code"] == "54000") {
          Logger().e("必填参数为空，请检查是否少传参数");
        } else if (responseBody["error_code"] == "54001") {
          Logger().e("签名错误，请检查您的签名生成方法");
        } else if (responseBody["error_code"] == "58000") {
          Logger().e(
              "客户端IP非法，请检查个人资料里填写的IP地址是否正确，可前往开发者信息-基本信息修改");
        } else if (responseBody["error_code"] == "54003") {
          Logger().e(
              "访问频率受限，请降低您的调用频率，或进行身份认证后切换为高级版");
        } else if (responseBody["error_code"] == "54004") {
          Logger().e("账户余额不足，请前往管理控制台为账户充值");
        } else if (responseBody["error_code"] == "54005") {
          Logger().e("长query请求频繁，请降低长query的发送频率，3s后再试");
        } else if (responseBody["error_code"] == "58001") {
          Logger().e("译文语言方向不支持，请检查译文语言是否在语言列表里");
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