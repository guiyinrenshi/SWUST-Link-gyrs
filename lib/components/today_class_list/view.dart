import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:swust_link/common/entity/oa/course.dart';

import '../../common/global.dart';
import '../../common/model/font_size_model.dart';
import 'logic.dart';
import 'state.dart';

class TodayClassListPage extends StatelessWidget {
  TodayClassListPage(List<Course> todayCourseList, {super.key}) {
    state.todayList.value = todayCourseList;
  }

  final TodayClassListLogic logic = Get.put(TodayClassListLogic());
  final TodayClassListState state = Get.find<TodayClassListLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        // 圆角
        borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(0, 4),
            ),
          ]
      ),
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "今日课程",
                        style: TextStyle(
                          fontSize:
                        (FontType.CARD_TITLE.size + Global.font.value) *
                            1.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
                const Divider(
                  color: Colors.white54,
                  thickness: 1,
                ),
                if (state.todayList.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        "今日无课程",
                        style: TextStyle(
                          fontSize:
                        (FontType.TITLE.size + Global.font.value) *
                            1.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  )
                else
                  ...state.todayList.map((course) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 节次信息
                          Container(
                            width: 40.w,
                            alignment: Alignment.center,
                            child: Text(
                              "${course.session}",
                              style:  TextStyle(
                                fontSize: (FontType.TITLE.size -2+ Global.font.value) *
                                    1.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          // 课程信息
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  course.className,
                                  style:  TextStyle(
                                    fontSize: (FontType.TITLE.size -2+ Global.font.value) *
                                        1.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "教师: ${course.teacher}",
                                  style:  TextStyle(
                                      fontSize: (FontType.TITLE.size -4+ Global.font.value) *
                                          1.0, color: Colors.grey),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "教室: ${course.location}",
                                  style:  TextStyle(
                                      fontSize: (FontType.TITLE.size -4+ Global.font.value) *
                                          1.0, color: Colors.grey),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "时间: ${course.period} 第${course.session}节",
                                  style:  TextStyle(
                                      fontSize: (FontType.TITLE.size -4+ Global.font.value) *
                                          1.0, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
              ],
            ),
          )),
    );
  }
}
