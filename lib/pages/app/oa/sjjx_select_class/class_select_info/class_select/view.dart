import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/global.dart';
import '../../../../../../common/model/font_size_model.dart';
import '../../../../../../components/acg_background/view.dart';
import '../../../../../../spider/sjjx_class_table.dart';
import 'logic.dart';

class Class_selectPage extends StatelessWidget {
  final String id;
  final int exp;
  final String name;

  Class_selectPage(
      {super.key, required this.id, required this.exp, required this.name}) {
    logic.getData(id, exp);
  }

  final Class_selectLogic logic = Get.put(Class_selectLogic());

  @override
  Widget build(BuildContext context) {
    return AcgBackgroundComponent(
        title: Text("实践选课-$name",
            style: TextStyle(
                fontSize:
                    (FontType.TOP_NAV_FONT.size + Global.font.value) * 1.0)),
        child: Obx(
          () {
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
                subtitle: Text(
                    "时间: ${course.schedule}\n老师: ${course.instructor}\n地点: ${course.location}\n人数: ${course.availableSeats}/${course.maxStudents}"),
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
                trailing: course.id == "已选"
                    ?  Text("取消选择")
                    : TextButton(onPressed: () async {
                      Get.snackbar("请求结果", (await (await SJJXTable.getInstance())?.selectClass(course.id, id))!);
                      logic.getData(id, exp);
                }, child: Text("点击选择")),
              );
            },
          );}
        ));
  }
}
