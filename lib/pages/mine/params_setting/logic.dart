import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'state.dart';

class Params_settingLogic extends GetxController {
  final Params_settingState state = Params_settingState();

  Future<void> saveSettings(String firstDay, String queryTime, bool isEnabled) async{
    final prefs = await SharedPreferences.getInstance();

    // 保存到 SharedPreferences
    await prefs.setString("firstDay", firstDay);
    await prefs.setString("queryTime", queryTime);
    await prefs.setBool("isAutoQueryEnabled", isEnabled);

    print("设置已保存: $firstDay, $queryTime, $isEnabled");
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    // 加载设置
    final firstDay = prefs.getString("firstDay") ?? "";
    final queryTime = prefs.getString("queryTime") ?? "";
    final isEnabled = prefs.getBool("isAutoQueryEnabled") ?? false;
    state.autoQueryTimeController.text = queryTime;
    state.firstDayController.text = firstDay;
    state.isAutoQueryEnabled.value = isEnabled;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadSettings();
  }
}
