import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:swust_link/components/acg_background/view.dart';

import '../../../../common/global.dart';
import '../../../../common/model/font_size_model.dart';
import 'logic.dart';
import 'state.dart';

class DuifeneCoursePage extends StatelessWidget {
  DuifeneCoursePage({Key? key}) : super(key: key);

  final DuifeneCourseLogic logic = Get.put(DuifeneCourseLogic());
  final DuifeneCourseState state = Get.find<DuifeneCourseLogic>().state;

  @override
  Widget build(BuildContext context) {
    return AcgBackgroundComponent(
        title: Text("对分易课程",style: TextStyle(
            fontSize:
            (FontType.TOP_NAV_FONT.size + Global.font.value) * 1.0)),
        actions: [TextButton(onPressed: logic.joinClass, child: Text("加入班级"))],
        child: Obx(
          () => ListView.builder(
            itemCount: state.courses.length,
            itemBuilder: (context, index) {
              final course = state.courses[index];
              return ListTile(
                title: Text(course.courseName),
                subtitle: Text("${course.termName} - ${course.className}"),
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color((course.courseName.hashCode) | 0xFF000000),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    course.courseName[0], // 使用文字的首字母作为图标
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                trailing: TextButton(
                    onPressed: () {
                      logic.showSignInfo(course);
                    },
                    child: Text("签到码签到")),
              );
            },
          ),
        ));
  }
}
