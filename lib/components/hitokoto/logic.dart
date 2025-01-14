import 'dart:convert';

import 'package:get/get.dart';

import 'state.dart';
import 'package:http/http.dart' as http;

class HitokotoLogic extends GetxController {
  final HitokotoState state = HitokotoState();

  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
    await getHitokoto();
  }

  Future<void> getHitokoto() async {
    final res = await http.get(Uri.parse("https://v1.hitokoto.cn/"));
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      state.text.value = data['hitokoto'];
      state.creator.value = data['creator'];
    }
  }
}
