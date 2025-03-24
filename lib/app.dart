import 'dart:async';

import 'package:common/constant.dart';
import 'package:common/network/http_utils.dart';
import 'package:common/utils/config.dart';
import 'package:common/utils/log_utils.dart';
import 'package:common/utils/system_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/page/main_landing_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:settings/page/profile_page.dart';

import 'home_page.dart';
// 字节开源调试工具类
import 'package:flutter_ume/flutter_ume.dart'; // UME 框架
import 'package:flutter_ume_kit_console/flutter_ume_kit_console.dart'; // debugPrint 插件包
import 'package:flutter_ume_kit_device/flutter_ume_kit_device.dart'; // 设备信息插件包
import 'package:flutter_ume_kit_perf/flutter_ume_kit_perf.dart'; // 性能插件包
import 'package:flutter_ume_kit_show_code/flutter_ume_kit_show_code.dart'; // 代码查看插件包
import 'package:flutter_ume_kit_ui/flutter_ume_kit_ui.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _init();
  runZonedGuarded<Future<void>>(
    () async {
      if (kDebugMode && Constant.SHOW_UME) {
        PluginManager.instance // Register plugin kits
          ..register(const WidgetInfoInspector())
          ..register(const WidgetDetailInspector())
          ..register(const ColorSucker())
          ..register(AlignRuler())
          ..register(const ColorPicker()) // New feature
          ..register(const TouchIndicator()) // New feature
          ..register(Performance())
          ..register(const ShowCode())
          ..register(const MemoryInfoPage())
          ..register(CpuInfoPage())
          ..register(const DeviceInfoPanel())
          ..register(Console());
        runApp(const UMEWidget(
          child: MyApp(),
          enable: true,
        ));
      } else {
        runApp(const MyApp());
      }
    },
    (error, stackTrace) async {},
    zoneSpecification: ZoneSpecification(
      ///拦截print
      print: (Zone self, ZoneDelegate parent, Zone zone, String message) {
        if (parent != null) {
          parent.print(zone, message);
        }
      },

      /// 拦截未处理的异步错误
      handleUncaughtError: (Zone self, ZoneDelegate parent, Zone zone, Object error, StackTrace stackTrace) {
        parent.print(zone, '${error.toString()} $stackTrace');
      },
    ),
  );
}

/// flutter 在抛出异常时，会回调FlutterError.onError
void setErrorCallBack() {
  final error = FlutterError.onError;
  FlutterError.onError = (FlutterErrorDetails details) {
    error?.call(details);
    reportError(details);
  };
}

void reportError(FlutterErrorDetails errorDetails) {
  LogUtils.dogE("$errorDetails");
}

void _init() async {
  setErrorCallBack();
  HttpUtils.init();
  await Config.init();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: "/home",
      unknownRoute: GetPage(
          // 页面没找到时会到这个页面
          name: "/404",
          page: () => const Center(
                  child: Text(
                "PAGE NOT FOUND",
                style: TextStyle(color: Colors.red),
              ))),
      routingCallback: (routing) {
        LogUtils.d("app", "rout changed,current:${routing?.current}");
      },
      getPages: [
        GetPage(
            name: "/home",
            page: () => const MyHomePage(
                  title: '',
                )),
        GetPage(name: "/newslanding", page: () => MainLandingPage()),
        GetPage(name: "/profilePage", page: () => const ProfilePage()),
      ],
      localizationsDelegates: const [
        DefaultCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('zh', 'CN'),
      ],
      localeResolutionCallback: (Locale? locale, Iterable<Locale>? iterable) {
        LogUtils.d("app", "onLocaleChanged,current:${locale?.languageCode}");
        return locale;
      },
      home: Builder(
        builder: (context) {
          System.context = context;
          return const MyHomePage(title: 'Flutter Demo Home Page');
        },
      ),
    );
  }
}


