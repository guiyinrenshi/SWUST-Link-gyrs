import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';

import 'state.dart';

class SchoolMapLogic extends GetxController {
  final SchoolMapState state = SchoolMapState();

  @override
  void onInit() {
    super.onInit();
  }

  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {},
        onPageStarted: (String url) {
          // state.title.value = '加载中';
        },
        onPageFinished: (String url) {
          // state.title.value = '学校地图';
        },
        onHttpError: (HttpResponseError error) {
          // state.title.value = '发生错误';
        },
        onWebResourceError: (WebResourceError error) {
          // state.title.value = '发生错误';
        },
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://gis.swust.edu.cn/#/home?campus=78924')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse('https://gis.swust.edu.cn/#/home?campus=78924'));
}
