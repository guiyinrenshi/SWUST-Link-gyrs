import 'package:get/get.dart';
import 'package:swust_link/common/entity/app.dart';
import 'package:swust_link/common/global.dart';

import 'state.dart';

class AppCardLogic extends GetxController {
  final AppCardState state = AppCardState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadApps();
  }

  Future<void> loadApps() async {
    List<App> apps = await Global.localStorageService
        .loadFromLocal("enabledApps", App.fromJson);
    if (apps.isEmpty) {
      apps.addAll(App.getAllApp().take(6));
    }
    state.apps.value = apps;
  }


}
