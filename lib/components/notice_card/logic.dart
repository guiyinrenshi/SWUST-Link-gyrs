import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class NoticeCardLogic extends GetxController {
  final notice = "".obs;
  late Dio dio;

  @override
  void onInit() {
    super.onInit();
    dio = Dio();
    loadNotice();
  }

  Future<void> loadNotice() async {
    final noticeUrl =
        "https://alist.yudream.online/d/%E6%B8%B8%E5%AE%A2%E4%B8%BB%E7%9B%AE%E5%BD%95/SWUST%20Link/%E6%95%B0%E6%8D%AE%E6%96%87%E4%BB%B6/notice.json?sign=k5EQzbxUsNah8wQL5XF886yqDemxG2jWhvNtvL63tqg=:0";
    final res = await dio.get(noticeUrl);
    Logger().i(res.data['notice']);
    try {
      notice.value = res.data['notice'];
      if (notice.value.isEmpty) {
        notice.value = "当前无公告";
      }
    } catch (e) {
      notice.value = "当前无公告";
    }
  }
}
