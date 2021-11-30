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

  test('increment', () {
    HomePageProvider provider = HomePageProvider('title');
    expect(provider.counter, 0);
    provider.increment();
    expect(provider.counter, 1);
  });

  test('dispose', () {
    HomePageProvider provider = HomePageProvider('title');
    expect(provider.isDisposed, false);
    provider.dispose();
    expect(provider.isDisposed, true);
  });
}
