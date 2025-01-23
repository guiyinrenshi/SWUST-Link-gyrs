import 'package:get/get.dart';

import '../../../common/entity/app.dart';
import '../../../common/global.dart';
import 'state.dart';

class AppSettingsLogic extends GetxController {
  final AppSettingsState state = AppSettingsState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadApps();
  }

  Future<void> loadApps() async {
    // 获取所有应用
    state.apps.value = App.getAllApp();

    // 将所有应用加载到 appStatusMap 中，默认启用状态为 false
    state.allApps.clear();
    for (var app in  state.apps) {
      state.allApps[app.route] = false;
    }

    // 尝试从本地加载启用的应用列表
    List<App> loadedEnabledApps = await Global.localStorageService.loadFromLocal(
      "enabledApps",
    App.fromJson);

    // 根据加载的启用应用列表更新状态
    for (var app in loadedEnabledApps) {
      if ( state.allApps.containsKey(app.route)) {
        state.allApps[app.route] = true;
      }
    }

    // 如果本地没有保存启用的应用列表，则默认启用前 6 个应用
    if (loadedEnabledApps.isEmpty) {
      for (var app in  state.apps.take(6)) {
        state.allApps[app.route] = true;
      }
    }
  }

  void toggleAppEnabled(App app) {
    if (state.allApps.containsKey(app.route)) {
      state.allApps[app.route] = !( state.allApps[app.route] ?? false);
    }
  }

  Future<void> saveApps() async {
    // 保存启用的应用列表到本地
    List<String> enabledAppsRoutes =  state.allApps.entries
        .where((entry) => entry.value) // 筛选出启用的应用
        .map((entry) => entry.key) // 提取应用对象
        .toList();
    List<App> allApp = [];
    for (var app in state.apps){
      if (enabledAppsRoutes.contains(app.route)){
        allApp.add(app);
      }
    }

    await Global.localStorageService.saveToLocal(
      allApp,
      "enabledApps",
    );
  }

  bool isAppEnabled(App app) {
    return  state.allApps[app.route] ?? false;
  }
}
