///
/// homepage_provider_test
///
/// created by DZDcyj at 2021/11/28
///
import 'package:flutter_test/flutter_test.dart';
import 'package:xianren_app/page/homepage/view_model/homepage_provider.dart';

import '../base/app_module.dart';

void main() {
  init();

  test('currIndex', () {
    HomePageProvider provider = HomePageProvider();
    expect(provider.currIndex, 2);

    provider.currIndex = 0;
    expect(provider.currIndex, 0);
  });
}
