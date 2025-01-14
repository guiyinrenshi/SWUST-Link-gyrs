import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swust_link/pages/app/view.dart';
import 'package:swust_link/pages/home/view.dart';
import 'package:swust_link/pages/mine/view.dart';

class MainState {
  // MainState() {
  final List<String> title = ["首页", "应用", "我的"];
  final currentIndex = 0.obs;

  final page = [HomePage(), AppPage(), MinePage()];

  final List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
    BottomNavigationBarItem(icon: Icon(Icons.apps), label: "应用"),
    BottomNavigationBarItem(
        icon: Icon(Icons.supervised_user_circle), label: "我的")
  ];

  ///Initialize variables
// }
}
