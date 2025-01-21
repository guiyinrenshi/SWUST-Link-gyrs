import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class GPAComponent extends StatelessWidget {
  final double value; // 当前的值
  final String label; // 圆环标签
  final Color color; // 圆环颜色

  GPAComponent({Key? key, required this.value, required this.label, required this.color}) : super(key: key);

  final GPALogic logic = Get.put(GPALogic());
  final GPAState state = Get.find<GPALogic>().state;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 圆环展示
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 120,
              height: 120,
              child: CircularProgressIndicator(
                value: value / 5.0, // GPA 范围 [0, 4]
                strokeWidth: 8,
                backgroundColor: Colors.grey[200],
                color: color,
              ),
            ),
            Text(
              value.toStringAsFixed(3),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
