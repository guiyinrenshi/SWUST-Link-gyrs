import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:swust_link/common/entity/app.dart';
import 'package:swust_link/common/routes/app_pages.dart';

import 'logic.dart';
import 'state.dart';

class AppCardComponent extends StatelessWidget {
  AppCardComponent({Key? key}) : super(key: key);

  final AppCardLogic logic = Get.put(AppCardLogic());
  final AppCardState state = Get.find<AppCardLogic>().state;

  @override
  Widget build(BuildContext context) {
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
        child: Obx(() {
          return Padding(
              padding: EdgeInsets.all(20.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.apps,
                        size: 22.sp,
                      ),
                      SizedBox(width: 20),
                      Expanded(
                          child: Text(
                        "常用应用",
                        style: TextStyle(
                            fontSize: 22.sp, fontWeight: FontWeight.bold),
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
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, // 每行四个网格项
                      crossAxisSpacing: 10, // 横向间距
                      mainAxisSpacing: 10, // 纵向间距
                    ),
                    itemCount: state.apps.length,
                    itemBuilder: (context, index) {
                      final App app = state.apps[index];
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(app.route);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 48.h,
                              width: 48.w,
                              decoration: BoxDecoration(
                                color: Color((app.text.hashCode) | 0xFF000000),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                app.text[0], // 使用文字的首字母作为图标
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24.sp,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              app.text,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ));
        }));
  }
}
