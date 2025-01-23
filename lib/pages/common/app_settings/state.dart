import 'package:get/get.dart';
import 'package:swust_link/common/entity/app.dart';

class AppSettingsState {
  final apps = <App>[].obs;

  final allApps = <String, bool>{}.obs; // 使用 Map 管理启用状态
}
