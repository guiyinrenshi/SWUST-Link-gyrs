import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bugly/flutter_bugly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swust_link/common/global.dart';
import 'package:swust_link/common/routes/app_pages.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {

  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    // 初始化 Bugly
    await FlutterBugly.init(
      androidAppId: "3d7df40363",
      iOSAppId: "c906b295b4",
    );

    // 启动应用
    runApp(MyApp());
    Get.put(params_setting());
    getSetting();
    Logger().i("After getSetting called");
    Global.initialize();
  }, (error, stackTrace) {
    // 捕获未处理的异常并上传到 Bugly
    FlutterBugly.uploadException(
      message: error.toString(),
      detail: stackTrace.toString(),
    );
  });
}

class params_setting extends GetxController {
  static params_setting get to => Get.find();
  final RxBool isAnime = true.obs;
  final RxBool isUploadBg = true.obs;

  @override
  void onInit() {
    super.onInit();
    Logger().i("params_setting initialized with isAnime: ${isAnime.value}");
  }
}

Future<void> getSetting()async {
  final prefs = await SharedPreferences.getInstance();
  final isAnimePrefs = prefs.getBool("isAnime") ?? false;
  final isUploadBgPrefs = prefs.getBool("isUploadBg") ?? false;
  params_setting.to.isAnime.value = isAnimePrefs;
  params_setting.to.isUploadBg.value = isUploadBgPrefs;
  Logger().i("getSetting loaded with isAnime: $isAnimePrefs");
  Logger().i("getSetting loaded with isUploadBg: $isUploadBgPrefs");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 915),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
            title: "西科通",
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('zh', 'CN'), // 中文
              Locale('en', 'US'), // 英文
            ],
            locale: const Locale('zh', 'CN'),
            // 设置默认语言为中文
            debugShowCheckedModeBanner: false,
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
            onUnknownRoute: (settings) {
              return MaterialPageRoute(
                settings: settings,
                builder: (context) => Scaffold(
                  appBar: AppBar(
                    title: Text('Unknown Route'),
                  ),
                  body: Center(
                    child: Text('未知路由: ${settings.name}'),
                  ),
                ),
              );
            });
      },
    );

  }
}
