import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swust_link/components/acg_background/view.dart';

import '../../../../common/global.dart';
import '../../../../common/model/font_size_model.dart';
import 'logic.dart';
import 'state.dart';

class ExamPage extends StatelessWidget {
  ExamPage({Key? key}) : super(key: key);

  final ExamLogic logic = Get.put(ExamLogic());
  final ExamState state = Get.find<ExamLogic>().state;

  @override
  Widget build(BuildContext context) {
    return AcgBackgroundComponent(title: Text("考试查询",style: TextStyle(
    fontSize:
    (FontType.TOP_NAV_FONT.size + Global.font.value) * 1.0)), actions: [IconButton(
        onPressed: () async {
          state.exams.value = await logic.getExams();
        },
        icon: Icon(Icons.refresh))],child: Obx(() {
      if (state.isLoading.value) {
        // 显示加载占位符
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state.exams.isEmpty) {
        return Center(
          child: Text("当前无考试信息"),
        );
      }
      return Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: state.exams.length,
                itemBuilder: (context, index) {
                  final exam = state.exams[index];

                  // 动态生成随机背景颜色
                  final randomColor =
                  Color((exam.course.hashCode) | 0xFF000000);

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: randomColor,
                      child: Text(
                        exam.course[0],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(exam.course),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${exam.date} - ${exam.time}\n${exam.session}",
                        ),
                      ],
                    ),
                    trailing: Text(
                      "${exam.location}\n座位号: ${exam.seat}",
                      textAlign: TextAlign.center,
                    ),
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
