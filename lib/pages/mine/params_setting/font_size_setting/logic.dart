import 'package:get/get.dart';
import '../../../../common/model/font_size_model.dart';

class FontSizeSettingLogic extends GetxController {
  var sliderValue = 0.0.obs; // 默认偏移量为 0

  // 计算偏移后的字体大小
  List<Map<String, dynamic>> getAdjustedFontSizes() {
    List<int> offsets = [0, 1, 2, -1, -2, 0]; // 偏移规则

    return FontType.values.asMap().entries.map((entry) {
      int index = entry.key;
      FontType font = entry.value; // 修正这里，使用 entry.value 获取 FontType
      int adjustedSize = font.size + offsets[index] + sliderValue.value.toInt();
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
}
