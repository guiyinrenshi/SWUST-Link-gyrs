import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swust_link/common/model/font_size_model.dart';


import '../utils/local_sttorage.dart';

class Global {

  static RxBool isAnime = false.obs;
  static RxBool isUploadBg = false.obs;
  static RxString uploadBg = "".obs;
  static late SharedPreferences prefs;
  static late LocalStorageService localStorageService;
  static RxInt font = 0.obs;


  static Future<void> initialize() async {
    localStorageService = LocalStorageService();
    prefs = await SharedPreferences.getInstance();
    isAnime.value = prefs.getBool("isAnime") ?? false;
    isUploadBg.value = prefs.getBool("isUploadBg") ?? false;
    uploadBg.value = prefs.getString("uploadBgPath") ?? "";
    font.value = prefs.getInt("fontSettingSize") ?? 0;
  }

  static int getFontSize(FontType ft){
    int size = ft.size + font.value;
    font.refresh();
    return size;
  }

}
