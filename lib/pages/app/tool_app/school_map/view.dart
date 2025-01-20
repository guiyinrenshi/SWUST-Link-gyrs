import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class SchoolMapPage extends StatelessWidget {
  SchoolMapPage({super.key});

  final SchoolMapLogic logic = Get.put(SchoolMapLogic());
  final SchoolMapState state = Get.find<SchoolMapLogic>().state;
  final TextEditingController inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(state.title.value)),
      body: WebViewWidget(controller: logic.controller),
    );
  }
}
