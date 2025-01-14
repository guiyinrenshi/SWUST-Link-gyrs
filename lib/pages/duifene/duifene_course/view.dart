import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class DuifeneCoursePage extends StatelessWidget {
  DuifeneCoursePage({Key? key}) : super(key: key);

  final DuifeneCourseLogic logic = Get.put(DuifeneCourseLogic());
  final DuifeneCourseState state = Get.find<DuifeneCourseLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(child: Text("对分易课程")),
            TextButton(onPressed: logic.joinClass, child: Text("加入班级"))

          ],
        ),
      ),
      body: Obx(
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
            );
          },
        ),
      ),

    );
  }
}
