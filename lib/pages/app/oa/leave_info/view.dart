import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swust_link/common/routes/app_pages.dart';
import 'package:swust_link/components/acg_background/view.dart';

import 'logic.dart';
import 'state.dart';

class LeaveInfoPage extends StatelessWidget {
  LeaveInfoPage({Key? key}) : super(key: key);

  final LeaveInfoLogic logic = Get.put(LeaveInfoLogic());
  final LeaveInfoState state = Get.find<LeaveInfoLogic>().state;

  @override
  Widget build(BuildContext context) {
    return AcgBackgroundComponent(
        title: Text("日常请假"),
        actions: [TextButton(onPressed: (){
          Get.toNamed(AppRoutes.MAIN+AppRoutes.LEAVE_PAGE);
        }, child: Text("新增"))],
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (state.records.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: state.records.length,
                  itemBuilder: (context, index) {
                    final record = state.records[index];
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      color: Colors.white,
                      child: ListTile(
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("请假时间: ${record.leaveTime}"),
                            Text("事由类型: ${record.leaveType}"),
                            Text("外出地点: ${record.location}"),
                            Text("状态: ${record.status}",
                                style: TextStyle(
                                  color: record.status.contains("通过")
                                      ? Colors.green
                                      : Colors.red,
                                )),
                            Text("请假状态: ${record.leaveState}"),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            Obx(() {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: state.currentPage.value > 1
                          ? logic.previousPage
                          : null,
                      child: Text("上一页"),
                    ),
                    Text(
                        "第 ${state.currentPage.value} 页 / 共 ${state.totalPages.value} 页"),
                    ElevatedButton(
                      onPressed:
                          state.currentPage.value < state.totalPages.value
                              ? logic.nextPage
                              : null,
                      child: Text("下一页"),
                    ),
                  ],
                ),
              );
            }),
          ],
        ));
  }
}
