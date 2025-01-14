import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  final MainLogic logic = Get.put(MainLogic());
  final MainState state = Get.find<MainLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Obx(() => Text(state.title[state.currentIndex.value])),
        ),
        body: Obx(() => state.page[state.currentIndex.value]),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            items: state.bottomNavItems,
            currentIndex: state.currentIndex.value,
            // type: BottomNavigationBarType.shifting,
            onTap: (index) {
              logic.changePage(index);
            },
          ),
        ));
  }
}
