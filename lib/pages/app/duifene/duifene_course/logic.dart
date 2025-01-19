import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common/global.dart';
import 'state.dart';

class DuifeneCourseLogic extends GetxController {
  final DuifeneCourseState state = DuifeneCourseState();

  @override
  void onInit() {
    super.onInit();
    loadDuifene();
  }

  Future<void> loadDuifene() async {
    if (Global.isLoginDfe) {
      state.courses.value = (await Global.duiFenE?.getCourseInfo())!;
    } else {
      Get.snackbar("未登录", "请先在我的-账号信息中保存信息");
    }
  }

  Future<void> joinClass() async {
    Get.dialog(
      AlertDialog(
        title: Text("加入班级"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "班级码(5位字母)",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: state.classIdController.value,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Get.back();
              String? msg = await Global.duiFenE
                  ?.joinClass(state.classIdController.value.text);
              Get.snackbar("", msg!);
            },
            child: Text("确定"),
          ),
        ],
      ),
    );
  }

  Future<void> showSignInfo(course) async {
    var data = await Global.duiFenE?.getSignCode(course.tClassID);

    Get.dialog(Dialog(
      child: SizedBox(
        width: 300.w, // 设置对话框宽度
        height: 500.h,
        child: Column(
          mainAxisSize: MainAxisSize.min, // 确保 Column 根据内容调整大小
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("签到列表",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            if (data!.isNotEmpty)
              TextButton(
                child: const Text("一键签到"),
                onPressed: () async {
                  var data =
                      await Global.duiFenE?.getSignCode(course.tClassID);

                  String msg =
                      await Global.duiFenE?.signIn(data![0].checkInCode)??"";
                  Get.snackbar("签到结果", msg);
                },
              ),
            data.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("暂无签到信息"),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final checkIn = data[index];
                        return ListTile(
                          title: Text(checkIn.createrDate),
                          leading: Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                              color: Color(
                                  (checkIn.statusName.hashCode) | 0xFF000000),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              checkIn.statusName[0], // 使用文字的首字母作为图标
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          trailing: Text(checkIn.statusName),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    ));
  }
}
