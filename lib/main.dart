import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:swust_link/common/global.dart';
import 'package:swust_link/common/routes/app_pages.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 确保插件初始化前绑定 Widgets
  if(window.physicalSize.isEmpty){
    window.onMetricsChanged = (){
      //在回调中，size仍然有可能是0
      if(!window.physicalSize.isEmpty){
        window.onMetricsChanged = null;
        runApp(const MyApp());
      }
    };
  } else{
    //如果size非0，则直接runApp
    runApp(const MyApp());
  }
  Global.initialize();

  runApp(const MyApp());
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
