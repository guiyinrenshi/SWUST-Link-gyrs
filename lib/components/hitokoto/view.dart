import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/global.dart';
import '../../common/model/font_size_model.dart';
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
          borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset(0, 4),
              ),
            ]
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
                    style: TextStyle(fontSize:
                    (FontType.CARD_TITLE.size + Global.font.value) *
                        1.0, fontWeight: FontWeight.bold),
                  )),
                  // IconButton(onPressed: logic.getHitokoto, icon: Icon(Icons.refresh))
                ],
              ),
              SizedBox(height: 10,),

              Row(
                children: [Obx(() => Expanded(child: Text(state.text.value == ""?"未获取到信息": state.text.value)))],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Expanded(
                      child: Obx(
                    () => Text(
                      "—— ${state.creator.value == ""?"无":state.creator.value}",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize:
                      (FontType.TITLE.size + Global.font.value) *1.0)
                    ),
                  ))
                ],
              )
            ],
          ),
        ));
  }
}
