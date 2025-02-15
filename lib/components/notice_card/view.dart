import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/global.dart';
import '../../common/model/font_size_model.dart';
import 'logic.dart';

class NoticeCardComponent extends StatelessWidget {
  NoticeCardComponent({Key? key}) : super(key: key);

  final NoticeCardLogic logic = Get.put(NoticeCardLogic());

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
            ]),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.notifications_none,
                    size: 22,
                  ),
                  SizedBox(width: 20),
                  Expanded(
                      child: Text(
                    "公告",
                    style:
                        TextStyle(fontSize:
                        (FontType.CARD_TITLE.size + Global.font.value) *
                            1.0, fontWeight: FontWeight.bold),
                  )),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Obx(() => Text(
                    logic.notice.value,
                    softWrap: true,
                style: TextStyle(
                    fontSize:
                    (FontType.DES.size + Global.font.value) *
                        1.0),
                  ))
            ],
          ),
        ));
  }
}
