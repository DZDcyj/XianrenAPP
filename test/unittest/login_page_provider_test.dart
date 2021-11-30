///
/// login_page_provider_test
///
/// created by DZDcyj at 2021/11/28
///
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xianren_app/page/login_page/view_model/login_page_provider.dart';

import '../base/app_module.dart';

void main() {
  init();

  LoginPageProvider provider = LoginPageProvider();

  setUp(() {
    SharedPreferences.setMockInitialValues({
      'username': 'mockUsername',
      'password': 'mockPassword',
      'autoLogin': true,
      'autoInput': true,
    });
  });

  test('initialize', () {
    provider.initialize().then((_) {
      expect(provider.username, 'mockUsername');
      expect(provider.password, 'mockPassword');
      expect(provider.autoLogin, true);
      expect(provider.autoInput, true);
    });
  });

  test('login', () {
    bool success = false;
    provider.login(() {
      success = true;
    }).then((_) {
      expect(success, true);
    });
  });

  test('clearInfoFromPreferences', () {
    provider.clearInfoFromPreferences().then((_) {
      expect(provider.autoInput, false);
    });
  });
}
