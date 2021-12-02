///
/// login_page_provider_test
///
/// created by DZDcyj at 2021/11/28
///
import 'dart:convert';

import 'package:dartin/dartin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xianren_app/bean/bean.dart';
import 'package:xianren_app/page/login_page/view_model/login_page_provider.dart';
import 'package:xianren_app/utils/net_util.dart';

import '../base/app_module.dart';
import '../base/data.dart';

void main() {
  init();

  LoginPageProvider provider = LoginPageProvider();

  NetUtil netUtil = get();

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
    when(netUtil.post<MapEntity>(any)).thenAnswer(
      (realInvocation) => Stream.fromFuture(
        Future.value(
          HttpResponseEntity<MapEntity>.fromJson(
            json.decode(successResponse),
          ),
        ),
      ),
    );
    // TODO: fix the test
    provider.doLogin(
      () {
        success = true;
        debugPrint('success');
        expect(success, true);
      },
    );
  });

  test('clearInfoFromPreferences', () {
    provider.clearInfoFromPreferences().then((_) {
      expect(provider.autoInput, false);
    });
  });
}
