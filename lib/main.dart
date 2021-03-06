///
/// main
///
/// created by DZDcyj at 2021/11/28
///
import 'package:dartin/dartin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:xianren_app/app_module.dart';
import 'package:xianren_app/page/init_page/view/init_page.dart';

void main() {
  startDartIn(appModule);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anonymous',
      navigatorObservers: [inject<NavigatorObserver>()],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InitPage(),
      supportedLocales: [
        Locale('zh', 'CH'),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
