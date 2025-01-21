import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swust_link/common/global.dart';
import 'package:swust_link/components/acg_background/view.dart';

import 'logic.dart';
import 'state.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  final MainLogic logic = Get.put(MainLogic());
  final MainState state = Get.find<MainLogic>().state;

  @override
  Widget build(BuildContext context) {
    return AcgBackgroundComponent(
        bottomNavigationBar: Obx(() => BottomNavigationBar(
              backgroundColor: Color(0x9cffffff),
              selectedItemColor: Colors.cyan,
              items: state.bottomNavItems,
              currentIndex: state.currentIndex.value,
              onTap: (index) {
                logic.changePage(index);
              },
            )),
        title: Obx(() => Text(state.title[state.currentIndex.value])),
        child: Obx(() => state.page[state.currentIndex.value]));
  }
}
