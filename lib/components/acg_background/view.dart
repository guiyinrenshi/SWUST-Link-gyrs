import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swust_link/common/global.dart';
import 'package:swust_link/components/acg_background/state.dart';

import 'logic.dart';

class AcgBackgroundComponent extends StatelessWidget {
  final Widget child;
  final Widget title;
  final List<Widget>? actions;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;

  AcgBackgroundComponent(
      {super.key,
      required this.child,
      required this.title,
      this.actions,
      this.bottomNavigationBar,
      this.floatingActionButton});

  final AcgBackgroundLogic logic = Get.put(AcgBackgroundLogic());
  final AcgBackgroundState state = Get.find<AcgBackgroundLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 背景图片
        Obx(
          () => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Global.isUploadBg.value
                    ? FileImage(File(Global.uploadBg.value))
                    : AssetImage(state.image.value.isEmpty
                        ? "assets/images/1.jpg" // 默认背景
                        : state.image.value),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        // 添加偏浅色蒙版
        Container(
          color: Colors.white.withOpacity(0.2), // 偏浅白色蒙版，透明度 0.4
        ),
        // 添加磨砂效果
        // BackdropFilter(
        //   filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0), // 轻度磨砂
        //   child: Container(
        //     color: Colors.transparent, // 背景透明以展示磨砂
        //   ),
        // ),
        // 前景内容
        Obx(
          () => Scaffold(
            floatingActionButton: floatingActionButton,
            backgroundColor: Global.isAnime.value || Global.isUploadBg.value
                ? Colors.transparent
                : const Color(0xfff3f4f6),
            appBar: AppBar(
              backgroundColor: Global.isAnime.value || Global.isUploadBg.value
                  ? Colors.transparent
                  : const Color(0xfff3f4f6),
              title: title,
              actions: actions,
            ),
            body: child,
            bottomNavigationBar: bottomNavigationBar,
          ),
        )
      ],
    );
  }
}
