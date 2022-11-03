import 'package:flustars/flustars.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:wit_niit/app/config/net_url.dart';

import 'app/data/theme_data.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/request.dart';

Request request = Request();
void main() async {
  // 请求单例初始化
  request.init(
    baseUrl: NetUrl.kHttp_HostName,
    responseFormat: HttpResponseFormat('code', 'data', 'msg', '1'),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp, // 竖屏 Portrait 模式
      DeviceOrientation.portraitDown,
      // DeviceOrientation.landscapeLeft, // 横屏 Landscape 模式
      // DeviceOrientation.landscapeRight,
    ],
  );

  ///打印log相关配置
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  LogUtil.init(isDebug: kDebugMode, maxLen: 800, tag: packageInfo.appName);
  await SpUtil.getInstance(); // 等待sp初始化完成后再运行app
  LogUtil.v('App启动～～'); // debug 模式输出
  runApp(MyApp());
  configLoading();
}

/// 吐司配置 https://github.com/nslogx/flutter_easyloading/blob/master/README-zh_CN.md
void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 1500)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)

    ///是否交互
    ..userInteractions = false;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (context, _) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: '智慧南工',
        theme: defaultTheme,
        darkTheme: appDarkTheme,
        themeMode: ThemeMode.light,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes, // 命名路由配置
        builder: EasyLoading.init(),
      ),
    );
  }
}
