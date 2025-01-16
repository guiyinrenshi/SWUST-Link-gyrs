import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class DuifeneWorkPage extends StatelessWidget {
  DuifeneWorkPage({Key? key}) : super(key: key);

  final DuifeneWorkLogic logic = Get.put(DuifeneWorkLogic());
  final DuifeneWorkState state = Get.find<DuifeneWorkLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(child: Text("对分易作业")),
            Text("筛选"),
            Obx(()=>Switch(
                value: state.isShowComplete.value,
                onChanged: (value) {
                  
                  state.isShowComplete.value = value;
                  state.workList.refresh();
                }))
          ],
        ),
      ),
      body: Obx(() {
        if (state.isLoading.value) {
          // 显示加载占位符
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.workList.isEmpty) {
          return Center(
            child: Text("无作业"),
          );
        }

        // 显示教学评价列表
        return Column(
          children: [
            Obx(()=>Expanded(
              child: ListView.builder(
                itemCount: state.workList.length,
                itemBuilder: (context, index) {
                  if (state.isShowComplete.value) {
                    if (state.workList[index].isSubmit) {
                      return SizedBox.shrink();
                    }
                  }
                  final work = state.workList[index];

                  // 动态生成随机背景颜色
                  final randomColor =
                  Color((work.hWName.hashCode) | 0xFF000000);
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: randomColor,
                      child: Text(
                        work.hWName[0],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(work.hWName),
                    subtitle: Text("${work.courseID} 结束: ${work.endDate}"),
                    trailing: Column(
                      children: [
                        Text(work.isSubmit
                            ? "提交人数: ${work.submitNumber}"
                            : "未提交"),
                      ],
                    ),
                  );
                },
              ),
            ))
          ],
        );
      }),
    );
  }
}
