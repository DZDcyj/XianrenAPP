///
/// main
///
/// created by DZDcyj at 2021/11/28
///
import 'package:xianren_app/app_module.dart';
import 'package:xianren_app/page/init_page/view/init_page.dart';
import 'package:xianren_app/router/router.dart';
import 'package:dartin/dartin.dart';
import 'package:flutter/material.dart';

void main() {
  startDartIn(appModule);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorObservers: [CustomNavigatorObserver.getInstance()],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InitPage(),
    );
  }
}
