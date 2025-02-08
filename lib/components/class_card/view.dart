import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:swust_link/common/entity/oa/course.dart';

import 'logic.dart';
import 'state.dart';

class Class_cardComponent extends StatelessWidget {
  Class_cardComponent(List<Course> todayCourseList, {Key? key})
      : super(key: key) {
    state.todayCourseList.value = todayCourseList;
  }

  final Class_cardLogic logic = Get.put(Class_cardLogic());
  final Class_cardState state = Get.find<Class_cardLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 10.r,
              spreadRadius: 2,
              offset: Offset(0, 4),
            ),
          ]
          ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Obx(
                        () => Text(state.time.value >= 0 ? "下一课程:" : "当前课程"))),
                Expanded(
                    child: Obx(() => Text(
                          state.time.value >= 0
                              ? "${logic.formatTime(state.time.value)} 后上课"
                              : "正在上课中",
                          textAlign: TextAlign.right,
                        )))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                    child: Obx(() => Text(
                          state.className.value,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        )))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.class_,
                  size: 30,
                  color: Colors.blue[200],
                ),
                Expanded(
                    child: Obx(() => Text(
                          state.placeName.value,
                          textAlign: TextAlign.right,
                        )))
              ],
            )
          ],
        ),
      ),
    );
  }
}
