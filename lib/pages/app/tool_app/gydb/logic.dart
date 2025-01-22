import 'package:get/get.dart';
import 'package:swust_link/common/entity/gydb/df.dart';
import 'package:swust_link/spider/gydb.dart';

import 'state.dart';

class GydbLogic extends GetxController {
  final GydbState state = GydbState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initGYDB();
  }

  Future<void> initGYDB() async {
    state.url.value = (await GYDB.getGydb())!.getQrCodeUrl();
    DianFei? df = await (await GYDB.getGydb())?.getDF();
    state.room.value = df!.roomName;
    state.df.value = df.roomMoney;
  }
}
