///
/// init_page_test
///
/// created by DZDcyj at 2021/11/28
///
import 'package:dartin/dartin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:xianren_app/main.dart';

import '../base/app_module.dart';
import '../base/base.dart';

void main() {
  init();
  final observer = inject<NavigatorObserver>();

  testWidgets('InitPage', (WidgetTester tester) async {
    await showWidget(tester, MyApp());
    expect(find.text('Welcome to Anonymous!'), findsOneWidget);

    // Stop the timer
    await tester.pumpAndSettle(Duration(seconds: 1));
    verify(observer.didPush(any, any));
  });
}
