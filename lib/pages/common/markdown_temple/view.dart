import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class MarkdownTemplePage extends StatelessWidget {
  MarkdownTemplePage(String title, String markdownFile, {Key? key})
      : super(key: key) {
    state.title.value = title;
    state.markdownFile = markdownFile;
    logic.loadMarkdown();
  }

  final MarkdownTempleLogic logic = Get.put(MarkdownTempleLogic());
  final MarkdownTempleState state = Get
      .find<MarkdownTempleLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Obx(() => Text(state.title.value)),), body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() =>
            Markdown(
              data: state.markdownStr.value,
              styleSheet: MarkdownStyleSheet(
                h1: TextStyle(fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent),
                h2: TextStyle(fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey),
                p: TextStyle(fontSize: 16, color: Colors.black87),
                listBullet: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),)
    ));
  }
}
