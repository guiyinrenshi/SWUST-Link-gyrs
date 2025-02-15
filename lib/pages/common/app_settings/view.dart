import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swust_link/components/acg_background/view.dart';

import '../../../common/global.dart';
import '../../../common/model/font_size_model.dart';
import 'logic.dart';
import 'state.dart';

class AppSettingsPage extends StatelessWidget {
  AppSettingsPage({Key? key}) : super(key: key);

  final AppSettingsLogic logic = Get.put(AppSettingsLogic());
  final AppSettingsState state = Get.find<AppSettingsLogic>().state;

  @override
  Widget build(BuildContext context) {
    return AcgBackgroundComponent(
      title: Text("常用应用设置",style: TextStyle(
          fontSize:
          (FontType.TOP_NAV_FONT.size + Global.font.value) * 1.0),),
      actions: [
        TextButton(
          onPressed: () async {
            await logic.saveApps(); // 保存启用的应用列表
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("设置已保存")),
            );
          },
          child: Text("保存"),
        ),
      ],
      child: Obx(() {
        return ReorderableListView.builder(
          itemCount: state.apps.length,
          itemBuilder: (context, index) {
            final app = state.apps[index];
            return ListTile(
              key: Key(app.route),
              title: Text(app.text),
              trailing: Switch(
                value: state.allApps[app.route] ?? false,
                onChanged: (value) {
                  logic.toggleAppEnabled(app);
                  state.apps.refresh();
                },
              ),
              onTap: () {
                // 可以在这里添加点击事件
              },
            );
          },
          onReorder: (oldIndex, newIndex) {
            // 调整应用顺序
            final app = state.apps.removeAt(oldIndex);
            state.apps.insert(newIndex, app);
          },
        );
      }),
    );
  }
}
