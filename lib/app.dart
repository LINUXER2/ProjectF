import 'dart:async';

import 'package:common/network/http_utils.dart';
import 'package:common/utils/config.dart';
import 'package:common/utils/log_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main/page/main_landing_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/cupertino.dart';

import 'home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _init();
  runZonedGuarded<Future<void>>(
    () async {
      runApp(const MyApp());
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
          return const MyHomePage(title: 'Flutter Demo Home Page');
        },
      ),
    );
  }
}


