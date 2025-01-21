import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swust_link/common/global.dart';

import 'state.dart';

class Params_settingLogic extends GetxController {
  final Params_settingState state = Params_settingState();

  Future<void> saveSettings(String firstDay, String queryTime, bool isAutoQuery, bool isAnime) async{
    final prefs = await SharedPreferences.getInstance();

    // 保存到 SharedPreferences
    await prefs.setString("firstDay", firstDay);
    await prefs.setString("queryTime", queryTime);
    await prefs.setBool("isAutoQueryEnabled", isAutoQuery);
    await prefs.setBool("isAnime", isAnime);
    Global.isAnime.value = isAnime;
    state.isAnime.value = isAnime;
    print("设置已保存: $firstDay, $queryTime, $isAutoQuery, $isAnime");
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    // 加载设置
    final firstDay = prefs.getString("firstDay") ?? "";
    final queryTime = prefs.getString("queryTime") ?? "";
    final isEnabled = prefs.getBool("isAutoQueryEnabled") ?? false;
    final isAnime = prefs.getBool("isAnime") ?? false;
    state.autoQueryTimeController.text = queryTime;
    state.firstDayController.text = firstDay;
    state.isAutoQueryEnabled.value = isEnabled;
    state.isAnime.value = isAnime;

    Logger().i(state.isAnime.value);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadSettings();
  }
}
