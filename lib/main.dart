import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swust_link/common/routes/app_pages.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 确保插件初始化前绑定 Widgets
  await FlutterDownloader.initialize(
    debug: true, // 设置为 true 以启用调试日志
    ignoreSsl: true, // 如果需要忽略 SSL 验证
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
  }
}
