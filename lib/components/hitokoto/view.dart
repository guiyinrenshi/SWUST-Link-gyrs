import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class HitokotoPage extends StatelessWidget {
  HitokotoPage({Key? key}) : super(key: key);

  final HitokotoLogic logic = Get.put(HitokotoLogic());
  final HitokotoState state = Get.find<HitokotoLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.textsms_outlined,
                    size: 22,
                  ),
                  SizedBox(width: 20),
                  Expanded(
                      child: Text(
                    "一言",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  )),
                  // IconButton(onPressed: logic.getHitokoto, icon: Icon(Icons.refresh))
                ],
              ),
              SizedBox(height: 10,),

              Row(
                children: [Obx(() => Text(state.text.value == ""?"未获取到信息": state.text.value))],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Expanded(
                      child: Obx(
                    () => Text(
                      "—— ${state.creator.value == ""?"无":state.creator.value}",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 15),
                    ),
                  ))
                ],
              )
            ],
          ),
        ));
  }
}
