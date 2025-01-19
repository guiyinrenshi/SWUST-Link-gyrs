import 'package:get/get.dart';

import '../../../../common/global.dart';
import 'state.dart';

class DuifeneWorkLogic extends GetxController {
  final DuifeneWorkState state = DuifeneWorkState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadDuifene();
  }

  Future<void> loadDuifene() async {
    if (Global.isLoginDfe) {
      state.workList.value = (await Global.duiFenE?.getAllWorkList())!;
      state.isLoading.value = false;
    } else {
      Get.snackbar("未登录", "请先在我的-账号信息中保存信息");
    }
  }
}
