import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swust_link/components/acg_background/view.dart';
import 'package:swust_link/pages/app/oa/sjjx_select_class/class_select_info/view.dart';

import '../../../../common/global.dart';
import '../../../../common/model/font_size_model.dart';
import 'logic.dart';

class SJJXSelectClassPage extends StatelessWidget {
  SJJXSelectClassPage({Key? key}) : super(key: key);

  final SJJXSelectClassLogic logic = Get.put(SJJXSelectClassLogic());

  @override
  Widget build(BuildContext context) {
    return AcgBackgroundComponent(
        title: Text("实践选课",
            style: TextStyle(
                fontSize:
                    (FontType.TOP_NAV_FONT.size + Global.font.value) * 1.0)),
        child: Obx(() {
          if (logic.isLoading.value) {
            // 显示加载占位符
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (logic.courseList.isEmpty) {
            return Center(child: Text("暂未选课"));
          }

          return ListView.builder(
            itemCount: logic.courseList.length,
            itemBuilder: (context, index) {
              final course = logic.courseList[index];
              return ListTile(
                title: Text(course.name),
                subtitle: Text("课程编码: ${course.id}\n课程学时: ${course.hours}"),
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color((course.name.hashCode) | 0xFF000000),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    course.name[0], // 使用文字的首字母作为图标
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                trailing: TextButton(
                    onPressed: () {
                      Get.to(ClassSelectInfoPage(
                        id: course.id,
                        name: course.name,
                      ));
                    },
                    child: Text("点击选择")),
              );
            },
          );
        }));
  }
}
