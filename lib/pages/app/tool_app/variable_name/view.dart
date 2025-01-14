import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class VariableNamePage extends StatelessWidget {
  VariableNamePage({Key? key}) : super(key: key);

  final VariableNameLogic logic = Get.put(VariableNameLogic());
  final VariableNameState state = Get.find<VariableNameLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
