import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:swust_link/components/acg_background/view.dart';
import '../../../../common/global.dart';
import '../../../../common/model/font_size_model.dart';
import 'logic.dart';
import 'state.dart';

class ClassTablePage extends StatelessWidget {
  ClassTablePage(String title, String url, {super.key}) {
    state.title.value = title;
    state.url.value = url;
    logic.loadClassTable();
  }

  final ClassTableLogic logic = Get.put(ClassTableLogic());
  final ClassTableState state = Get.find<ClassTableLogic>().state;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return AcgBackgroundComponent(
      title: Text(
        state.title.value,
        style: TextStyle(
          fontSize: (FontType.TOP_NAV_FONT.size + Global.font.value) * 1.0,
        ),
      ),
      actions: [
        IconButton(onPressed: (){logic.loadClassTable();}, icon: Icon(Icons.refresh)),
        Obx(
              () => DropdownButton<int>(
            value: state.currentWeek.value,
            onChanged: (value) {
              if (value != null) {
                state.currentWeek.value = value;
                _pageController.jumpToPage(value - 1);
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
      child: PageView.builder(
        controller: _pageController,
        itemCount: 20,
        onPageChanged: (index) {
          state.currentWeek.value = index + 1;
        },
        itemBuilder: (context, pageIndex) {
          return Obx(() {
            if (state.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                Obx(
                      () => Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text("讲数"),
                        ),
                      ),
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
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${currentDate.month}.${currentDate.day}",
                                  style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
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
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text("${sessionIndex + 1}"),
                                ),
                              ),
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
                                    margin: EdgeInsets.only(
                                        left: 2.w, right: 2.w, top: 1.h, bottom: 1.h),
                                    child: courses.isNotEmpty
                                        ? Column(
                                      children: courses
                                          .map((course) => Expanded(
                                        child: GestureDetector(
                                          onTap: () {
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
                                                      Text("地点: ${course.location}"),
                                                      Text("时间: 第${course.session}讲"),
                                                      Text("周次: ${course.startTime}-${course.endTime}周"),
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
                                            margin: EdgeInsets.only(bottom: 1.h),
                                            padding: EdgeInsets.all(4.w),
                                            decoration: BoxDecoration(
                                              color: logic.getCourseColor(course.className),
                                              borderRadius:
                                              BorderRadius.circular(4.r),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    course.className,
                                                    textAlign: TextAlign.center,
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: (FontType.DES.size + 1 + Global.font.value) * 1.0,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    course.teacher,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: (FontType.DES.size + Global.font.value) * 1.0,
                                                    ),
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    "@${course.location}",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: (FontType.DES.size - 1 + Global.font.value) * 1.0,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ))
                                          .toList(),
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
            );
          });
        },
      ),
    );
  }
}