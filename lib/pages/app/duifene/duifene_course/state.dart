import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:swust_link/spider/duifene.dart';


class DuifeneCourseState {

  late DuiFenE duifeneClient;
  final RxList<Course> courses = <Course>[].obs;
  final classIdController = TextEditingController().obs;
}
