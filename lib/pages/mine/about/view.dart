import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swust_link/components/acg_background/view.dart';

import 'logic.dart';
import 'state.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  AboutPage({Key? key}) : super(key: key);

  final AboutLogic logic = Get.put(AboutLogic());
  final AboutState state = Get.find<AboutLogic>().state;

  @override
  Widget build(BuildContext context) {
    return AcgBackgroundComponent(
        title: Text('关于我们'),
        actions: [],
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20), // 圆角半径
                        child: Image.asset(
                          "assets/app.png",
                          width: 100, // 图片宽度
                          height: 100, // 图片高度
                          fit: BoxFit.cover, // 图片填充模式
                        ),
                      ),
                    ))
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Obx(
                  () => Row(
                    children: [
                      Expanded(
                        child: Text(
                          state.appName.value,
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
                Obx(
                  () => Row(
                    children: [
                      Expanded(
                          child: Text(
                        "版本号: ${state.version.value}",
                        textAlign: TextAlign.center,
                      ))
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(onPressed: logic.checkNew, child: Text("检查更新"))
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  "关于应用",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  "应用由Flutter开发, 力争推出最实用便捷的西南科技大学掌上教务平台。",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 16),
                Text(
                  "开发人员",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  "信安2303 SiberianHusky",
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  "卓软2201 Player877",
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  "软件2305 TsMinato",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 16),
                Text(
                  "关于广告位",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  "广告联系SiberianHusky, 提前准备好标题 描述和相关链接",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 16),
                Text(
                  "联系我们",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                GestureDetector(
                  onTap: () async {
                    final email = Uri(
                      scheme: 'mailto',
                      path: '3088506834@qq.com',
                    );
                    if (await canLaunchUrl(email)) {
                      await launchUrl(email);
                    } else {
                      Get.dialog(AlertDialog(
                        title: Text('无法打开邮箱应用'),
                        content: Text('请安装邮箱应用后重试。'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('确定'),
                          ),
                        ],
                      ));
                      throw '无法打开邮箱应用';
                    }
                  },
                  child: Column(
                    children: [
                      Text(
                        "邮箱: 3088506834@qq.com",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      GestureDetector(
                        onTap: logic.callQQ,
                        child: Text(
                          "西科通QQ交流群: 950969163",
                          style: TextStyle(fontSize: 15),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child:
                          Text("蜀ICP备2025122527号", textAlign: TextAlign.center),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
