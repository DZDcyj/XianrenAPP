///
/// base
///
/// created by DZDcyj at 2021/11/28
///
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> tap(WidgetTester tester, Finder finder) async {
  await tester.tap(finder);
  await tester.pump();
}

Future<void> showWidget(WidgetTester tester, Widget widget, {Duration duration}) async {
  if (widget is! MediaQuery && widget is! MaterialApp) {
    widget = MaterialApp(
      home: widget,
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
  await tester.pumpWidget(widget);
  if (duration != null) {
    await tester.pumpAndSettle(duration);
  }
  await tester.pump();
}
