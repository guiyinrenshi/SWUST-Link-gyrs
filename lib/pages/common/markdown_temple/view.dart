import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:swust_link/components/acg_background/view.dart';

import '../../../common/global.dart';
import '../../../common/model/font_size_model.dart';
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
  final MarkdownTempleState state = Get.find<MarkdownTempleLogic>().state;

  @override
  Widget build(BuildContext context) {
    return AcgBackgroundComponent(
        title: Text(state.title.value,style: TextStyle(
            fontSize:
            (FontType.TOP_NAV_FONT.size + Global.font.value) * 1.0),),
        actions: [],
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Obx(
              () => Markdown(
                data: state.markdownStr.value,
                styleSheet: MarkdownStyleSheet(
                  h1: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent),
                  h2: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey),
                  p: TextStyle(fontSize: 16, color: Colors.black87),
                  listBullet: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ),
            )));
  }
}
