///
/// init_page_test
///
/// created by DZDcyj at 2021/11/28
///
import 'package:flutter_test/flutter_test.dart';
import 'package:xianren_app/main.dart';

import '../base/app_module.dart';
import '../base/base.dart';

void main() {
  init();

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await showWidget(tester, MyApp());
    expect(find.text('Welcome to Xianren APP!'), findsOneWidget);

    // Stop the timer
    await tester.pumpAndSettle(Duration(seconds: 1));
  });
}
