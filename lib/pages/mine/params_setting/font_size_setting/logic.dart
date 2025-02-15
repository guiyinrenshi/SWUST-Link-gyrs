import 'package:get/get.dart';
import 'package:swust_link/common/global.dart';
import '../../../../common/model/font_size_model.dart';

class FontSizeSettingLogic extends GetxController {
  var sliderValue = 0.0.obs; // 默认偏移量为 0

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    sliderValue.value = Global.font.value * 1.0;
  }

  // 计算偏移后的字体大小
  List<Map<String, dynamic>> getAdjustedFontSizes() {
    return FontType.values.asMap().entries.map((entry) {
      FontType font = entry.value; // 修正这里，使用 entry.value 获取 FontType
      int adjustedSize = font.size + sliderValue.value.toInt();
      return {
        "font": font, // 这里使用 font 而不是 entry
        "size": adjustedSize
      };
    }).toList();
  }

  // 更新字体偏移量
  void updateFontOffset(int value) {
    sliderValue.value = value.toDouble();
  }

  Future<void> saveFontSetting() async {
    await Global.prefs.setInt("fontSettingSize", sliderValue.value.toInt());
    Global.font.value = sliderValue.value.toInt();
    Get.snackbar("成功", "保存字体设置成功, 当前字体偏移为${sliderValue.value}!");
  }
}
