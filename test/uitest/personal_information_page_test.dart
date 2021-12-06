///
/// personal_information_page_test
///
/// created by DZDcyj at 2021/11/30
///
import 'dart:async';
import 'dart:convert';

import 'package:dartin/dartin.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xianren_app/bean/bean.dart';
import 'package:xianren_app/page/homepage/view/personal_information_page.dart';
import 'package:xianren_app/utils/net_util.dart';

import '../base/app_module.dart';
import '../base/base.dart';
import '../base/data.dart';

void main() {
  init();

  NetUtil netUtil = inject();

  testWidgets('PersonalInformationPage', (WidgetTester tester) async {
    when(netUtil.getAllInfo()).thenAnswer(
      (realInvocation) => Stream.fromFuture(
        Future.value(
          HttpResponseEntity<UserInformationEntity>.fromJson(
            json.decode(successInfoResponse),
          ),
        ),
      ),
    );

    await showWidget(tester, PersonalInformationPage());

    await tap(tester, find.text('修改匿名'));

    SharedPreferences.setMockInitialValues({
      'autoLogin': true,
    });
    await tap(tester, find.text('退出登录'));
  });

  testWidgets('PersonalInformationPage', (WidgetTester tester) async {
    // 其他错误
    when(netUtil.getAllInfo()).thenAnswer(
      (realInvocation) => Stream.fromFuture(
        Future.value(
          HttpResponseEntity<UserInformationEntity>.fromJson(
            json.decode(failedResponse),
          ),
        ),
      ),
    );

    await showWidget(tester, PersonalInformationPage());
  });

  testWidgets('PersonalInformationPage', (WidgetTester tester) async {
    // Session 失效
    when(netUtil.getAllInfo()).thenAnswer(
      (realInvocation) => Stream.fromFuture(
        Future.value(
          HttpResponseEntity<UserInformationEntity>.fromJson(
            json.decode(sessionInvalidResponse),
          ),
        ),
      ),
    );

    await showWidget(tester, PersonalInformationPage());
  });
}
