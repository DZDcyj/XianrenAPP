///
/// home_page_test
///
/// created by DZDcyj at 2021/11/28
///
import 'package:flutter_test/flutter_test.dart';
import 'package:xianren_app/page/homepage/view/homepage.dart';

import '../base/app_module.dart';
import '../base/base.dart';

void main() {
  init();

  testWidgets('HomePage', (WidgetTester tester) async {
    HomePage page = HomePage();
    await showWidget(tester, page);
  });
}
