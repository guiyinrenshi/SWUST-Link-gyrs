import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../common/model/entity_model.dart';

class LocalStorageService {
  /// 保存数据到本地文件
  Future<void> saveToLocal<T  extends JsonSerializable>(List<T> items, String fileName) async {
    try {
      // 获取应用的文档目录
      final directory = await getApplicationDocumentsDirectory();
      final filePath = "${directory.path}/$fileName.json";

      // 将数据转换为 JSON 字符串
      final jsonString = jsonEncode(items.map((item) => item.toJson()).toList());
      // 写入本地文件
      final file = File(filePath);
      await file.writeAsString(jsonString);

      print("Data saved to $filePath");
    } catch (e) {
      print("Failed to save data: $e");
    }
  }

  /// 从本地文件加载数据
  Future<List<T>> loadFromLocal<T>(
      String fileName, T Function(Map<String, dynamic>) fromJson) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = "${directory.path}/$fileName.json";

      final file = File(filePath);

      if (await file.exists()) {
        final jsonString = await file.readAsString();
        final List<dynamic> jsonList = jsonDecode(jsonString);

        // 将 JSON 列表转换为对应类型列表
        return jsonList.map((json) => fromJson(json)).toList();
      } else {
        print("Local file does not exist: $filePath");
        return [];
      }
    } catch (e) {
      print("Failed to load data: $e");
      return [];
    }
  }
}



