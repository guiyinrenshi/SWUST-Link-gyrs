import 'package:get/get.dart';
import 'package:swust_link/spider/duifene.dart';
import '../../../../common/global.dart';
import 'state.dart';

class DuifenePaperLogic extends GetxController {
  final DuifenePaperState state = DuifenePaperState();

  @override
  void onInit() {
    super.onInit();
    loadDuifene();
  }

  Future<void> loadDuifene() async {
    try{
      state.papers.value = (await (await DuiFenE.getInstance())!.getAllPager());
      state.isLoading.value = false;
    } catch(e) {
      Get.snackbar("未登录", "请先在我的-账号信息中保存信息");
    }
  }
}
