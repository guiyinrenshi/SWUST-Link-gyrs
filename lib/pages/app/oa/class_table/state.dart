import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:swust_link/spider/class_table.dart';
import 'package:swust_link/common/entity/oa/course.dart';
import 'package:swust_link/spider/sjjx_class_table.dart';

class ClassTableState {
  late SJJXTable sjjxTable;
  final RxList<Course> courses = <Course>[].obs;
  final Map<String, Color> courseColors = {};
  final List<Color> predefinedColors = [
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.amberAccent,
    Colors.purpleAccent,
    Colors.orangeAccent,
    Colors.tealAccent,
    Colors.redAccent,
    Colors.lightBlueAccent,
    Colors.lightGreenAccent,
    Colors.deepOrangeAccent,
    Colors.deepPurpleAccent,
    Colors.pinkAccent,
    Colors.limeAccent,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
    Colors.lightBlue,
    Colors.lightGreen,
    Colors.orange,
    Colors.teal,
    Colors.cyan,
    Colors.indigo,
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepOrange,
    Colors.deepPurple,
    Colors.amber,
  ];

  final firstDay = DateTime(2025, 1, 1).obs; // 默认本学期第一天
  final url = "".obs;
  final title = "".obs;
  final currentWeek = 1.obs;
  final isLoading = true.obs;

}
