import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class DuifeneWorkPage extends StatelessWidget {
  DuifeneWorkPage({Key? key}) : super(key: key);

  final DuifeneWorkLogic logic = Get.put(DuifeneWorkLogic());
  final DuifeneWorkState state = Get.find<DuifeneWorkLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("对分易作业"),),
      body: ListView(

      ),
    );
  }
}
