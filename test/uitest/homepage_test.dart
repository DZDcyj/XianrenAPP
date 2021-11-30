///
/// home_page_test
///
/// created by DZDcyj at 2021/11/28
///
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xianren_app/page/homepage/view/homepage.dart';

import '../base/app_module.dart';
import '../base/base.dart';

void main() {
  init();

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await showWidget(tester, HomePage('title'));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tap(tester, find.byIcon(Icons.add));

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
