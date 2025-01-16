import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'logic.dart';
import 'state.dart';

class ClassTablePage extends StatelessWidget {
  ClassTablePage(String title, String url, {super.key}){
    state.title.value = title;
    state.url.value = url;
    logic.loadClassTable();
  }

  final ClassTableLogic logic = Get.put(ClassTableLogic());
  final ClassTableState state = Get.find<ClassTableLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff3f4f6),
      appBar: AppBar(
        backgroundColor: Color(0xfff3f4f6),
        title: Row(
          children: [
            Expanded(
              child: Text(
                state.title.value,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ],
        ),
        actions: [
          Obx(
            () => DropdownButton<int>(
              value: state.currentWeek.value,
              onChanged: (value) {
                if (value != null) {
                  state.currentWeek.value = value;
                }
              },
              items: List.generate(
                20,
                (index) => DropdownMenuItem(
                  value: index + 1,
                  child: Text("第${index + 1}周"),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // 表头：星期
          Obx(
            () => Flex(
              direction: Axis.horizontal,
              children: [
                // 第一列为 "讲数"
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text("讲数"),
                  ),
                ),
                // 周一至周日
                ...List.generate(7, (index) {
                  final currentDate = logic
                      .getWeekStartDate(state.currentWeek.value)
                      .add(Duration(days: index));
                  return Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "周${["一", "二", "三", "四", "五", "六", "日"][index]}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${currentDate.month}.${currentDate.day}",
                            style: TextStyle(
                                color: Colors.grey, fontSize: 12.sp),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          // 表格主体
          Obx(
            () => Expanded(
              flex: 7,
              child: Column(
                children: List.generate(6, (sessionIndex) {
                  return Expanded(
                    flex: 2,
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        // 第一列显示讲数
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text("${sessionIndex + 1}"),
                          ),
                        ),
                        // 周一至周日课程
                        ...List.generate(7, (weekDayIndex) {
                          final courses = logic.filteredCourses
                              .where((list) => list.any((course) =>
                                  course.weekDay == weekDayIndex + 1 &&
                                  course.session == sessionIndex + 1))
                              .expand((list) => list)
                              .toList();

                          return Expanded(
                            flex: 1,
                            child: Container(
                              margin: EdgeInsets.only(left: 2.w,right: 2.w,top: 1.h,bottom: 1.h),
                              child: courses.isNotEmpty
                                  ? Column(
                                      children:
                                          courses.asMap().entries.map((entry) {
                                        final index = entry.key;
                                        final course = entry.value;
                                        return Expanded(
                                          child: GestureDetector(
                                            onTap: (){
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text(course.className),
                                                    content: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Text("教师: ${course.teacher}"),
                                                        Text(
                                                            "地点: ${course.location}"),
                                                        Text(
                                                            "时间: 第${course.session}讲"),
                                                        Text(
                                                            "周次: ${course.startTime}-${course.endTime}周"),
                                                      ],
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.of(context)
                                                                .pop(),
                                                        child: const Text("关闭"),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                            margin: EdgeInsets.only(
                                                bottom: 2.h),
                                            padding: EdgeInsets.only(left: 4.w,right: 4.w,top: 4.h,bottom: 4.h),
                                            decoration: BoxDecoration(
                                              color: logic.getCourseColor(
                                                  course.className),
                                              borderRadius:
                                              BorderRadius.circular(4.r),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  course.className,
                                                  maxLines: 2,
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  course.teacher,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13.sp,
                                                  ),
                                                ),
                                                Text(
                                                  "@${course.location}",
                                                  style:TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11.sp,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),)
                                        );
                                      }).toList(),
                                    )
                                  : null,
                            ),
                          );
                        }),
                      ],
                    ),
                  );
                }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
