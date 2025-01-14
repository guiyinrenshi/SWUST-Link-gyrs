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
                  color: Color(int.parse(course.backgroundColor.replaceAll("#", "0xFF"))),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    course.courseName[0],
                    style: TextStyle(color: Color(int.parse(course.color.replaceAll("#", "0xFF")))),
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
