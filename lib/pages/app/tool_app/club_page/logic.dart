import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:swust_link/common/entity/tool_app/club_info.dart';
import 'package:url_launcher/url_launcher.dart';

class ClubPageLogic extends GetxController {
  final clubList = <ClubInfo>[].obs;
  final dio = Dio();

  @override
  void onInit() {
    super.onInit();
    getClubList();
  }

  Future<void> getClubList() async {
    final url =
        "https://alist.yudream.online/d/%E6%B8%B8%E5%AE%A2%E4%B8%BB%E7%9B%AE%E5%BD%95/SWUST%20Link/%E6%95%B0%E6%8D%AE%E6%96%87%E4%BB%B6/%E7%A4%BE%E5%9B%A2%E5%90%8D%E5%BD%95/main.json?sign=pT95Eg4gTv2hGn2nRQvZ0sB8lMP3D4PbdTDuVqz6_q8=:0";
    final res = await dio.get(url);
    List<dynamic> data = res.data;
    clubList.clear();
    for (var item in data){
      Logger().i(item);
      clubList.add(ClubInfo.fromJson(item));

    }
    // data.map((club) {clubList.add(ClubInfo.fromJson(club));Logger().i(club);});

    clubList.refresh();
  }

  void callQQ({String number = "950969163", bool isGroup = true}) async {
    String url = isGroup
        ? 'mqqapi://card/show_pslcard?src_type=internal&version=1&uin=${number ?? 0}&card_type=group&source=qrcode'
        : 'mqqwpa://im/chat?chat_type=wpa&uin=${number ?? 0}&version=1&src_type=web&web_src=oicqzone.com';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      Get.snackbar("错误", "未检测到 QQ 应用，请安装后重试。");
    }
  }
}
