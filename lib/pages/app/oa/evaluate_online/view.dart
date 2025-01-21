import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swust_link/components/acg_background/view.dart';

import 'logic.dart';
import 'state.dart';

class EvaluateOnlinePage extends StatelessWidget {
  EvaluateOnlinePage({Key? key}) : super(key: key);

  final EvaluateOnlineLogic logic = Get.put(EvaluateOnlineLogic());
  final EvaluateOnlineState state = Get.find<EvaluateOnlineLogic>().state;

  @override
  Widget build(BuildContext context) {
    return AcgBackgroundComponent(title:  Text("教学评价"), actions: [TextButton(
        onPressed: () {
          logic.showEPDialog(state.evaluatePaperList);
        },
        child: Text("一键提交"))],child: Obx(() {
      if (state.isLoading.value) {
        // 显示加载占位符
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state.evaluatePaperList.isEmpty) {
        return Center(
          child: Text("当前已无教学评价"),
        );
      }

      // 显示教学评价列表
      return Column(children: [
        Expanded(
          child: ListView.builder(
            itemCount: state.evaluatePaperList.length,
            itemBuilder: (context, index) {
              final evaluatePaper = state.evaluatePaperList[index];

              // 动态生成随机背景颜色
              final randomColor =
              Color((evaluatePaper.course.hashCode) | 0xFF000000);
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: randomColor,
                  child: Text(
                    evaluatePaper.course[0],
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(evaluatePaper.course),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${evaluatePaper.college} - ${evaluatePaper.teacher}'),
                  ],
                ),
                trailing: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                        onPressed: () {
                          logic.showEPDialog([evaluatePaper]);
                        },
                        child: Text("提交评价")),
                  ],
                ),
              );
            },
          ),
        )
      ],);
    }),);
  }
}
