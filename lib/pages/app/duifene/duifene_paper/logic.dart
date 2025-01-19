import 'package:get/get.dart';
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
    if (Global.isLoginDfe) {
      state.papers.value = (await Global.duiFenE?.getAllPager())!;
      state.isLoading.value = false;
    } else {
      Get.snackbar("未登录", "请先在我的-账号信息中保存信息");
    }
  }
}
