import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:swust_link/common/entity/app.dart';
import 'package:swust_link/common/routes/app_pages.dart';

import '../../common/global.dart';
import '../../common/model/font_size_model.dart';
import 'logic.dart';
import 'state.dart';

class AppCardComponent extends StatelessWidget {
  AppCardComponent({Key? key}) : super(key: key);

  final AppCardLogic logic = Get.put(AppCardLogic());
  final AppCardState state = Get.find<AppCardLogic>().state;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      logic.updateScreenWidth();
      return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 10.r,
                  spreadRadius: 2,
                  offset: Offset(0, 4),
                ),
              ]),
          child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.apps,
                        size: 22,
                      ),
                      SizedBox(width: 20),
                      Expanded(
                          child: Text(
                            "常用应用",
                            style: TextStyle(
                                fontSize: (FontType.CARD_TITLE.size  + Global.font.value) * 1.0 ,fontWeight: FontWeight.bold),
                          )),
                      IconButton(
                          onPressed: () {
                            Get.toNamed(AppRoutes.MAIN + AppRoutes.APP_SETTING);
                          },
                          icon: Icon(Icons.settings))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(() {
                    // 监听屏幕大小变化
                    double screenWidth =
                        state.screenWidth.value; // 这里获取 Rx 变量的值
                    int crossAxisCount =
                    (screenWidth / 100).floor(); // 限制最少1列，最多6列

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount, // 动态列数
                      ),
                      itemCount: state.apps.length,
                      itemBuilder: (context, index) {
                        App app = state.apps[index];
                        return GestureDetector(
                            onTap: () {
                              Get.toNamed(app.route as String);
                            },
                            child: SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 48,
                                    width: 48,
                                    decoration: BoxDecoration(
                                      color: Color(
                                          (app.text.hashCode) | 0xFF000000),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      app.text[0], // 使用文字的首字母作为图标
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Flexible(
                                    child: Text(
                                      app.text as String,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              ),
                            )
                        );
                      },
                    );
                  }),
                ],
              )));
    });
  }
}
