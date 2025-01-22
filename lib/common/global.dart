import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../utils/local_sttorage.dart';

class Global {

  static RxBool isAnime = false.obs;
  static late SharedPreferences prefs;
  static late LocalStorageService localStorageService;


  static Future<void> initialize() async {
    localStorageService = LocalStorageService();
    prefs = await SharedPreferences.getInstance();
    isAnime.value = prefs.getBool("isAnime") ?? false;
  }

}
