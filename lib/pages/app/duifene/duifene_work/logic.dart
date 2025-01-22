import 'package:get/get.dart';
import 'package:swust_link/spider/duifene.dart';

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
    try{
      state.workList.value = (await (await DuiFenE.getInstance())!.getAllWorkList());
      state.isLoading.value = false;
    } catch(e) {
      Get.snackbar("未登录", "请先在我的-账号信息中保存信息");
    }
  }
}
