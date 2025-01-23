import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';

import 'state.dart';

class YktLogic extends GetxController {
  final YktState state = YktState();

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
          if (request.url.startsWith("http://ykt.swust.edu.cn/plat/shouyeUser")) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse("http://ykt.swust.edu.cn/plat/shouyeUser"));
}
