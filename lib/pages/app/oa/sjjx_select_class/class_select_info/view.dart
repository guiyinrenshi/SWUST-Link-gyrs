import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swust_link/pages/app/oa/sjjx_select_class/class_select_info/class_select/view.dart';

import '../../../../../common/global.dart';
import '../../../../../common/model/font_size_model.dart';
import '../../../../../components/acg_background/view.dart';
import 'logic.dart';

class ClassSelectInfoPage extends StatelessWidget {
  final String id;
  final String name;

  ClassSelectInfoPage({Key? key, required this.id, required this.name})
      : super(key: key) {
    logic.getData(id);
  }

  final ClassSelectInfoLogic logic = Get.put(ClassSelectInfoLogic());

  @override
  Widget build(BuildContext context) {
    return AcgBackgroundComponent(
        title: Text("实践选课-$name",
            style: TextStyle(
                fontSize:
                    (FontType.TOP_NAV_FONT.size + Global.font.value) * 1.0)),
        child: Obx(
          (){
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
                subtitle: Text(course.expId.toString()),
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
                      Get.to(Class_selectPage(
                          name: name, exp: course.expId, id: id));
                    },
                    child: Text("点击选择")),
              );
            },
          );}
        ));
  }
}
