import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swust_link/components/acg_background/view.dart';

import '../../../../common/global.dart';
import '../../../../common/model/font_size_model.dart';
import 'logic.dart';

class ClubPagePage extends StatelessWidget {
  ClubPagePage({Key? key}) : super(key: key);

  final ClubPageLogic logic = Get.put(ClubPageLogic());

  @override
  Widget build(BuildContext context) {
    return AcgBackgroundComponent(
        title: Text("社团导航",style: TextStyle(
            fontSize:
            (FontType.TOP_NAV_FONT.size + Global.font.value) * 1.0)),
        child: Obx(
          () => ListView.builder(
            itemCount: logic.clubList.length,
            itemBuilder: (context, index) {
              final club = logic.clubList[index];
              return ListTile(
                title: Text(club.name),
                subtitle: Text(club.qq),
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color((club.name.hashCode) | 0xFF000000),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    club.name[0], // 使用文字的首字母作为图标
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                trailing: TextButton(
                    onPressed: () {
                      logic.callQQ(number: club.qq);
                    },
                    child: Text("加入")),
              );
            },
          ),
        ));
  }
}
