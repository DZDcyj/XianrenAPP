///
/// personal_information_modify_page_test
///
/// created by DZDcyj at 2021/12/7
///
import 'package:flutter_test/flutter_test.dart';
import 'package:xianren_app/page/homepage/view/personal_information/personal_information_modify_page.dart';
import 'package:xianren_app/utils/global_util.dart';

import '../base/app_module.dart';
import '../base/base.dart';

void main() {
  init();

  testWidgets('PersonalInformationModifyPage', (WidgetTester tester) async {
    await showWidget(
      tester,
      PersonalInformationModifyPage(
        '1234',
        DateTime(2000),
        Gender.secret,
        true,
        (value) {},
      ),
    );
  });
}
