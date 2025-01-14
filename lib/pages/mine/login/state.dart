import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swust_link/common/entity/account.dart';

class LoginState {
  final List<DropdownMenuEntry>dropDownItem = [

  ];

  final isShowPassword = true.obs;
  late Account account;
  final username = "".obs;
  final password = "".obs;
  final currentPlatform = 0.obs;
  final usernameController =  TextEditingController().obs;
  final passwordController = TextEditingController().obs;
}
