///
/// register_page_test
///
/// created by DZDcyj at 2021/11/30
///
import 'package:flutter_test/flutter_test.dart';
import 'package:xianren_app/page/login_page/view/register_page.dart';

import '../base/app_module.dart';
import '../base/base.dart';

void main() {
  init();

  testWidgets('RegisterPage', (WidgetTester tester) async {
    await showWidget(tester, RegisterPage());
  });
}
