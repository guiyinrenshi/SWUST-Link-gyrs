import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'state.dart';

class MarkdownTempleLogic extends GetxController {
  final MarkdownTempleState state = MarkdownTempleState();


  Future<void> loadMarkdown() async {
    try {
      // 从 assets 文件夹加载 changelog.md
      final String content =
          await rootBundle.loadString(state.markdownFile);
      state.markdownStr.value = content;
    } catch (e) {
      state.markdownStr.value = "加载失败，请稍后重试。";
      Logger().e(e);
    }
  }
}
