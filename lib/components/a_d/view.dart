import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/global.dart';
import '../../common/model/font_size_model.dart';
import 'logic.dart';

class ADComponent extends StatelessWidget {
  ADComponent({Key? key}) : super(key: key);

  final ADLogic logic = Get.put(ADLogic());

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
                    Icons.playlist_add_check_circle_sharp,
                    size: 22,
                  ),
                  SizedBox(width: 20),
                  Expanded(
                      child: Text(
                    "广告",
                    style: TextStyle(fontSize: (FontType.CARD_TITLE.size + Global.font.value) *
                        1.0, fontWeight: FontWeight.bold),
                  )),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Obx(() => logic.ads.isEmpty
                  ? Text("当前无广告")
                  : Column(
                      children: [
                        Obx(() => Text(
                              logic.currentAd['title'],
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                              softWrap: true,
                            )),
                        Obx(() => Text(
                              logic.currentAd['des'],
                              style: TextStyle(fontSize:(FontType.DES.size + Global.font.value) *
    1.0,),
                              softWrap: true,
                            )),
                        TextButton(
                            onPressed: () {
                              logic.openInBrowser(logic.currentAd['url']);
                            },
                            child: Text("相关链接"))
                      ],
                    ))
            ],
          ),
        ));
  }
}
