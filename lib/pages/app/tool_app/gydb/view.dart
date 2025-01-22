import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:swust_link/components/acg_background/view.dart';

import 'logic.dart';
import 'state.dart';

class GydbPage extends StatelessWidget {
  GydbPage({Key? key}) : super(key: key);

  final GydbLogic logic = Get.put(GydbLogic());
  final GydbState state = Get.find<GydbLogic>().state;

  @override
  Widget build(BuildContext context) {
    return AcgBackgroundComponent(
      actions: [
        IconButton(
            onPressed: () {
              logic.initGYDB();
            },
            icon: Icon(Icons.refresh))
      ],
      title: const Text("舍先生",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "寝室: ",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
                ),
                Obx(() => Text(
                      state.room.value,
                      style: TextStyle(fontSize: 15.sp),
                    ))
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Text(
                  "余额: ",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
                ),
                Obx(() => Text(state.df.value.toStringAsFixed(2),
                    style: TextStyle(fontSize: 15.sp)))
              ],
            ),
            SizedBox(height: 20.h),
            Obx(() {
              if (state.url.value.isNotEmpty) {
                return Center(
                  child: Image.network(
                    state.url.value,
                    fit: BoxFit.contain,
                    width: double.infinity,
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
