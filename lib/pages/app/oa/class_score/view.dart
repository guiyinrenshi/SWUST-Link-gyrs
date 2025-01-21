import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swust_link/components/acg_background/view.dart';
import 'package:swust_link/components/g_p_a/view.dart';

import 'logic.dart';
import 'state.dart';

class ClassScorePage extends StatelessWidget {
  ClassScorePage({Key? key}) : super(key: key);

  final ClassScoreLogic logic = Get.put(ClassScoreLogic());
  final ClassScoreState state = Get.find<ClassScoreLogic>().state;

  @override
  Widget build(BuildContext context) {
    return AcgBackgroundComponent(title: Text("成绩查询"),actions: [IconButton(onPressed: logic.getScore, icon: Icon(Icons.refresh))],child: Obx((){

      if (state.isLoading.value) {
        // 显示加载占位符
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state.scores.isEmpty) {
        return Center(
          child: Text("当前无成绩信息"),
        );
      }
      return Column(
        children: [
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // 当前学期平均绩点
              Obx(() => GPAComponent(
                value: state.averageGPA.value,
                label: "平均绩点",
                color: Colors.blue,
              )),
              // 当前学期必修绩点
              Obx(() => GPAComponent(
                value: state.bxGPA.value,
                label: "必修绩点",
                color: Colors.green,
              )),
            ],
          ),
          Obx(() {
            final semesters = logic.state.scores
                .map((course) => course.semester)
                .toSet()
                .toList();
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<String>(
                value: state.selectedSemester.value.isNotEmpty
                    ? state.selectedSemester.value
                    : null,
                hint: Text("选择学期"),
                items: semesters
                    .map((semester) => DropdownMenuItem(
                  value: semester,
                  child: Text(semester),
                ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    logic.updateSelectedSemester(value);
                  }
                },
                isExpanded: true,
              ),
            );
          }),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: state.displayList.length,
                itemBuilder: (context, index) {
                  final course = state.displayList[index];

                  // 动态生成随机背景颜色
                  final randomColor =
                  Color((course.name.hashCode) | 0xFF000000);

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: randomColor,
                      child: Text(
                        course.name[0],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(course.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${course.courseNature} - ${course.credit} 学分"),
                        if (course.retakeScore.isNotEmpty) // 检查补考数据是否存在
                          Text("补考: ${course.retakeScore}"),
                      ],
                    ),
                    trailing: Text("正考: ${course.examScore??"通过"}"),
                  );
                },
              );
            }),
          ),
        ],
      );
    }),);

  }
}
