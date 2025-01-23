import 'package:flutter/material.dart';
import 'package:swust_link/components/acg_background/view.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class YktPage extends StatelessWidget {
  YktPage({super.key});

  final YktLogic logic = Get.put(YktLogic());
  final YktState state = Get.find<YktLogic>().state;
  final TextEditingController inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AcgBackgroundComponent(
        title: Text(state.title.value),
        child: WebViewWidget(controller: logic.controller));
  }
}
