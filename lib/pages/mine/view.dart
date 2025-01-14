import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swust_link/common/routes/app_pages.dart';

import 'logic.dart';
import 'state.dart';

class MinePage extends StatelessWidget {
  MinePage({Key? key}) : super(key: key);

  final MineLogic logic = Get.put(MineLogic());
  final MineState state = Get.find<MineLogic>().state;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text("帐号信息"),
          onTap: () {
            Get.toNamed(AppRoutes.MAIN + AppRoutes.ACCOUNT);
          },
          leading: Icon(Icons.manage_accounts),
        ),
        ListTile(
          title: Text("参数设置"),
          onTap: () {
            Get.toNamed(AppRoutes.MAIN + AppRoutes.PARAMS_SETTING);
          },
          leading: Icon(Icons.settings),
        ),
        ListTile(
          title: Text("隐私与协议"),
          onTap: () {
            Get.toNamed(AppRoutes.MAIN + AppRoutes.PRIVACY_AND_PROTOCOL);
          },
          leading: Icon(Icons.privacy_tip_outlined),
        ),
        ListTile(
          title: Text("关于"),
          onTap: () {
            Get.toNamed(AppRoutes.MAIN + AppRoutes.ABOUT);
          },
          leading: Icon(Icons.info_outlined),
        ),
      ],
    );
  }
}
