import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swust_link/common/global.dart';

import 'state.dart';

class Params_settingLogic extends GetxController {
  final Params_settingState state = Params_settingState();

  Future<void> saveSettings(String firstDay, String queryTime, bool isAutoQuery,
      bool isAnime, bool isUploadBg) async {
    final prefs = await SharedPreferences.getInstance();

    // 保存到 SharedPreferences
    await prefs.setString("firstDay", firstDay);
    await prefs.setString("queryTime", queryTime);
    await prefs.setBool("isAutoQueryEnabled", isAutoQuery);
    await prefs.setBool("isAnime", isAnime);
    await prefs.setBool("isUploadBg", isUploadBg);
    Global.isAnime.value = isAnime;
    Global.isUploadBg.value = isUploadBg;
    state.isAnime.value = isAnime;
    state.isUploadBg.value = isUploadBg;

    print("设置已保存: $firstDay, $queryTime, $isAutoQuery, $isAnime ,$isUploadBg");
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    // 加载设置
    final firstDay = prefs.getString("firstDay") ?? "";
    final queryTime = prefs.getString("queryTime") ?? "";
    final isEnabled = prefs.getBool("isAutoQueryEnabled") ?? false;
    final isAnime = prefs.getBool("isAnime") ?? false;
    final isUploadBg = prefs.getBool("isUploadBg") ?? false;
    state.autoQueryTimeController.text = queryTime;
    state.firstDayController.text = firstDay;
    state.isAutoQueryEnabled.value = isEnabled;
    state.isAnime.value = isAnime;
    state.isUploadBg.value = isUploadBg;

    Logger().i(state.isAnime.value);
  }

  Future<void> checkImageSave() async {
    final prefs = await SharedPreferences.getInstance();
    final backgroundPath = prefs.getString("uploadBgPath") ?? "";
    if (backgroundPath == "") {
      if (!await pickAndSaveFile()) {
        state.isUploadBg.value = false;
        Global.isUploadBg.value = false;
      }
    }
  }

  Future<void> clearImage() async {
    final prefs = await SharedPreferences.getInstance();
    final backgroundPath = prefs.getString("uploadBgPath") ?? "";
    prefs.setString("uploadBgPath", "");
    Global.isUploadBg.value = false;
    state.isUploadBg.value = false;
    await prefs.setBool("isUploadBg", false);
    final file = File(backgroundPath);
    try {
      if (await file.exists()) {
        await file.delete();
        print("文件已成功删除: $backgroundPath");
      } else {
        print("文件不存在: $backgroundPath");
      }
    } catch (e) {
      print("删除文件时发生错误: $e");
    }
  }

  // 选择文件并保存到指定路径
  Future<bool> pickAndSaveFile() async {
    // 使用 file_picker 选择文件
    var isChange = false;
    var isSelect = false;
    if (Global.isUploadBg.value) {
      isChange = true;
      Global.isUploadBg.value = false;
    }
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      // 获取选中的文件
      File file = File(result.files.single.path!);

      // 获取应用的文档目录（可写目录）
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String newFilePath = '${appDocDir.path}/upload.png';
      File newFile = File(newFilePath);
      if (await newFile.exists()){
        newFile.delete();
      }
      File noMedia = File("${appDocDir.path}/.nomedia");
      if (!await noMedia.exists()) {
        noMedia.create();
      }
      // 将文件复制到新位置
      await file.copy(newFilePath);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("uploadBgPath", newFilePath);
      Global.uploadBg.value = newFilePath;
      isSelect = true;
    } else {
      // 用户取消了文件选择
      Get.snackbar(
        "文件选择取消",
        "未选择文件",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    if (isChange) {
      // 恢复原设置
      state.isUploadBg.value = true;
      Global.isUploadBg.value = true;
    }
    return isSelect;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadSettings();
  }
}
