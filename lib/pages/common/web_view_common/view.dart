import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swust_link/components/acg_background/view.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../common/global.dart';
import '../../../common/model/font_size_model.dart';
import 'logic.dart';

class WebViewCommonPage extends StatelessWidget {
  WebViewCommonPage({super.key, required title, required initUrl}) {
    logic.title.value = title;
    logic.initUrl.value = initUrl;
    logic.controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(logic.initUrl.value));
  }

  final WebViewCommonLogic logic = Get.put(WebViewCommonLogic());

  @override
  Widget build(BuildContext context) {
    return AcgBackgroundComponent(
      actions: [
        IconButton(
          icon: Icon(Icons.open_in_browser),
          onPressed: () => logic.openInBrowser(),
          tooltip: "在浏览器中打开",
        ),
        IconButton(
          icon: Icon(Icons.copy),
          onPressed: () => logic.copyToClipboard(),
          tooltip: "复制链接",
        ),
      ],
        title: Obx(() => Text(logic.title.value,style: TextStyle(
            fontSize:
            (FontType.TOP_NAV_FONT.size + Global.font.value) * 1.0),)),
        child: WebViewWidget(controller: logic.controller));
  }
}
