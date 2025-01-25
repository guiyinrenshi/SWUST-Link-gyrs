import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

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
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onHttpError: (HttpResponseError error) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith("http://ykt.swust.edu.cn/plat/shouyeUser")) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..enableZoom(false)
    ..setBackgroundColor(Colors.transparent)
    ..setUserAgent('Mozilla/5.0 (iPhone; CPU iPhone OS 14_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0 Mobile/15E148 Safari/604.1')
    ..enableZoom(false)
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse("http://ykt.swust.edu.cn/plat/shouyeUser"));
}
