import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class Params_settingState {
  final TextEditingController firstDayController = TextEditingController();
  final TextEditingController autoQueryTimeController = TextEditingController();
  final RxBool isAutoQueryEnabled = false.obs;
}
