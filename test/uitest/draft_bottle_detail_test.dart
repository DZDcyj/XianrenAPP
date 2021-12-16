///
/// draft_bottle_detail_test
///
/// created by DZDcyj at 2021/12/16
///
import 'package:flutter_test/flutter_test.dart';
import 'package:xianren_app/page/draft_bottle/view/draft_bottle_detail.dart';

import '../base/app_module.dart';
import '../base/base.dart';

void main() {
  init();

  testWidgets('description', (WidgetTester tester) async {
    await showWidget(tester, DraftBottleDetail(123));
  });
}
