import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:swust_link/common/entity/duifene/course.dart';


class DuifeneCourseState {

  final RxList<Course> courses = <Course>[].obs;
  final classIdController = TextEditingController().obs;
}
