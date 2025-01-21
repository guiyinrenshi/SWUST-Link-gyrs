import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swust_link/components/class_card/view.dart';
import 'package:swust_link/components/duifene_sign/view.dart';
import 'package:swust_link/components/hitokoto/view.dart';

import '../../components/today_class_list/view.dart';
import 'logic.dart';
import 'state.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final HomeLogic logic = Get.put(HomeLogic());
  final HomeState state = Get.find<HomeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Opacity(
                  opacity: 0.8,
                  child: Class_cardComponent(state.toDayCourses),
                ))
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                    child: Opacity(
                  opacity: 0.8,
                  child: TodayClassListPage(
                    state.toDayCourses,
                  ),
                ))
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                    child: Opacity(
                  opacity: 0.8,
                  child: HitokotoPage(),
                ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                    child: Opacity(
                  opacity: 0.8,
                  child: DuifeneSignComponent(),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
