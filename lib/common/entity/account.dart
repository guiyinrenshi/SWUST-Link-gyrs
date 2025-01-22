import 'package:swust_link/spider/duifene.dart';
import 'package:swust_link/spider/gydb.dart';
import 'package:swust_link/spider/oa_auth.dart';
import 'package:swust_link/spider/baidu_trans.dart';

class Account {
  String username;
  String password;
  int platformCode;

  Account(this.username, this.password, this.platformCode);

  Future<Map> testLogin() async {
    if (platformCode == 0) {
      var oa = OAAuth(
          service: "http://soa.swust.edu.cn/",
          username: username,
          password: password);
      if (await oa.login()) {
        return {'key': true, 'message': ""};
      } else {
        return {'key': false, 'message': "用户名或密码错误！"};
      }
    } else if (platformCode == 1) {
      var duifene = DuiFenE(username: username, password: password);
      if (await duifene.passwordLogin()) {
        return {'key': true, 'message': ""};
      } else {
        return {'key': false, 'message': "用户名或密码错误！"};
      }
    } else if (platformCode == 2) {
      var baiduTrans = BaiduTrans(appID: username, key: password);
      if (await baiduTrans.connect()) {
        return {'key': true, 'message': ""};
      } else {
        var errorMsg = baiduTrans.getErrorMsg();
        return {'key': false, 'message': errorMsg};
      }
    } else if(platformCode == 3){
      var gydb = GYDB(username: username, password: password);
      var res = await gydb.login();
      return {'key': res['flag'], 'message': res['msg']};

    }
    else {
      return {'key': true, 'message': ""};
    }
  }
}

enum Platform {
  OA(0, "一站式大厅"),
  DUIFENE(1, "对分易"),
  BAIDU(2, "百度翻译开放平台"),
  GYDB(3, "舍先生");

  final int code;
  final String des;

  const Platform(this.code, this.des);
}
