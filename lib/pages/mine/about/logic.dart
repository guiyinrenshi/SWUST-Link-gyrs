import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'state.dart';

class AboutLogic extends GetxController {
  final AboutState state = AboutState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _fetchAppInfo();
  }

  Future<void> _fetchAppInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    state.appName.value = packageInfo.appName;
    state.packageName.value = packageInfo.packageName;
    state.version.value = packageInfo.version;
    state.buildNumber.value = packageInfo.buildNumber;
  }

  void launch(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw '无法打开链接: $url';
    }
  }
}
