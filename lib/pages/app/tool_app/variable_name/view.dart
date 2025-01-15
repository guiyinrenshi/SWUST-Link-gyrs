import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class VariableNamePage extends StatelessWidget {
  VariableNamePage({super.key});

  final VariableNameLogic logic = Get.put(VariableNameLogic());
  final VariableNameState state = Get.find<VariableNameLogic>().state;
  final TextEditingController inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('起个变量名'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '起个变量名',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              controller: inputController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '输入文本',
              ),
            ),
            SizedBox(height: 16),
            Text(
              '输出(点击即可复制)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Obx(() => TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '全大写',
                  ),
                  onTap: () {
                    // 选择并复制文本
                    Clipboard.setData(
                        ClipboardData(text: state.variableNameAupper.value));
                    Get.snackbar('复制成功', '变量名已复制到剪贴板');
                  },
                  controller: TextEditingController(
                      text: state.variableNameAupper.value),
                )),
            SizedBox(height: 16),
            Obx(() => TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '全小写',
                  ),
                  onTap: () {
                    // 选择并复制文本
                    Clipboard.setData(
                        ClipboardData(text: state.variableNameAlower.value));
                    Get.snackbar('复制成功', '变量名已复制到剪贴板');
                  },
                  controller: TextEditingController(
                      text: state.variableNameAlower.value),
                )),
            SizedBox(height: 16),
            Obx(() => TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '大驼峰',
                  ),
                  onTap: () {
                    // 选择并复制文本
                    Clipboard.setData(
                        ClipboardData(text: state.variableNameSupper.value));
                    Get.snackbar('复制成功', '变量名已复制到剪贴板');
                  },
                  controller: TextEditingController(
                      text: state.variableNameSupper.value),
                )),
            SizedBox(height: 16),
            Obx(() => TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '小驼峰',
                  ),
                  onTap: () {
                    // 选择并复制文本
                    Clipboard.setData(
                        ClipboardData(text: state.variableNameSlower.value));
                    Get.snackbar('复制成功', '变量名已复制到剪贴板');
                  },
                  controller: TextEditingController(
                      text: state.variableNameSlower.value),
                )),
            SizedBox(height: 16),
            Obx(() => TextField(
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '全大写 + 下划线',
              ),
              onTap: () {
                // 选择并复制文本
                Clipboard.setData(
                    ClipboardData(text: state.variableNameUpperUnderline.value));
                Get.snackbar('复制成功', '变量名已复制到剪贴板');
              },
              controller: TextEditingController(
                  text: state.variableNameUpperUnderline.value),
            )),
            SizedBox(height: 16),
            Obx(() => TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '全小写 + 下划线',
                  ),
                  onTap: () {
                    // 选择并复制文本
                    Clipboard.setData(
                        ClipboardData(text: state.variableNameLowerUnderline.value));
                    Get.snackbar('复制成功', '变量名已复制到剪贴板');
                  },
                  controller: TextEditingController(
                      text: state.variableNameLowerUnderline.value),
                )),
            SizedBox(height: 16),
            Row(children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // 生成变量名的逻辑
                    logic.getVariableName(inputController.text);
                  },
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                    backgroundColor: WidgetStateProperty.all(Colors.blue),
                  ),
                  child: Text(
                    "生成",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ]),
          ],
        ),
      ),
    );
  }
}
