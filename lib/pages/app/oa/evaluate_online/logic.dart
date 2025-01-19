import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swust_link/common/entity/oa/evaluation_paper.dart';
import 'package:swust_link/spider/evaluate_online.dart';

import 'state.dart';

class EvaluateOnlineLogic extends GetxController {
  final EvaluateOnlineState state = EvaluateOnlineState();

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getEvalPaperList();
  }

  Future<void> getEvalPaperList() async {
    state.epClient = EvaluateOnline();
    state.evaluatePaperList.value =
        await state.epClient.getEvaluationPaperList();
    state.isLoading.value = false;
  }

  Future<void> showEPDialog(List<EvaluationPaper> data) async {
    final RxString selectedGrade = "".obs; // 默认值为空
    final TextEditingController commentController =
        TextEditingController(text: "无"); // 评论初始内容为 "无"
    final RxBool isSubmitting = false.obs; // 是否正在提交

    await Get.dialog(
      Obx(() => AlertDialog(
            title: Text("教学评价"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 下拉菜单选择评分等级
                Row(
                  children: [
                    Text("评分等级: "),
                    Expanded(
                      child: DropdownButton<String>(
                        value: selectedGrade.value.isEmpty
                            ? null
                            : selectedGrade.value,
                        items: [
                          DropdownMenuItem(
                            value: "1",
                            child: Text("非常满意"),
                          ),
                          DropdownMenuItem(
                            value: "2",
                            child: Text("满意"),
                          ),
                          DropdownMenuItem(
                            value: "3",
                            child: Text("基本满意"),
                          ),
                          DropdownMenuItem(
                            value: "4",
                            child: Text("不满意"),
                          ),
                        ],
                        onChanged: isSubmitting.value
                            ? null
                            : (value) {
                                selectedGrade.value = value!;
                              },
                        hint: Text("请选择评分等级"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                // 评论输入框
                TextField(
                  controller: commentController,
                  decoration: InputDecoration(
                    labelText: "意见和建议",
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  enabled: !isSubmitting.value, // 提交时禁用编辑框
                ),
              ],
            ),
            actions: [
              // 取消按钮
              TextButton(
                onPressed: () {
                  if (!isSubmitting.value) {
                    Get.back(); // 关闭对话框
                  }
                },
                child: Text("取消"),
              ),
              // 确认按钮
              TextButton(
                onPressed: () async {
                  if (selectedGrade.value.isEmpty) {
                    Get.snackbar("提示", "请选择一个等级");
                    return;
                  }
                  isSubmitting.value = true; // 开始提交
                  try {
                    for (var ep in data) {
                      try {
                        state.epClient.evaluateOne(
                            ep.toJson(),
                            commentController.text,
                            int.parse(selectedGrade.value));
                        Get.snackbar("成功", "${ep.course}评价已成功提交!");
                      } catch (e) {
                        Get.snackbar("错误", "提交失败，请重试");
                      }
                    }
                    Get.back(); // 关闭对话框
                    state.isLoading.value = false;
                    await getEvalPaperList();
                    state.isLoading.value = true;
                  } catch (e) {
                    Get.snackbar("错误", "提交失败，请重试");
                  } finally {
                    isSubmitting.value = false; // 恢复按钮可用
                  }
                },
                child: isSubmitting.value
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text("确认"),
              ),
            ],
          )),
      barrierDismissible: false, // 禁止点击对话框外关闭
    );
  }
}
