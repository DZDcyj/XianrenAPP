///
/// personal_information_page_test
///
/// created by DZDcyj at 2021/11/30
///
import 'dart:async';
import 'dart:convert';

import 'package:dartin/dartin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xianren_app/bean/bean.dart';
import 'package:xianren_app/page/homepage/view/personal_information/personal_information_page.dart';
import 'package:xianren_app/utils/net_util.dart';

import '../base/app_module.dart';
import '../base/base.dart';
import '../base/data.dart';

void main() {
  init();

  NetUtil netUtil = inject();

  /// 初始化获取信息 Mock
  void mockInitSuccessResponse() {
    when(netUtil.getAllInfo()).thenAnswer(
      (realInvocation) => Stream.fromFuture(
        Future.value(
          HttpResponseEntity<UserInformationEntity>.fromJson(
            json.decode(successInfoResponse),
          ),
        ),
      ),
    );
  }

  /// 修改匿名 Mock
  void mockModifyAnonymousResponse() {
    when(netUtil.modifyAnonymous({
      'phonenumber': '13666279971',
      'anonymname': 'asd',
    })).thenAnswer(
      (realInvocation) => Stream.fromFuture(
        Future.value(
          HttpResponseEntity<MapEntity>.fromJson(
            json.decode(successInfoResponse),
          ),
        ),
      ),
    );

    when(netUtil.modifyAnonymous({
      'phonenumber': '13666279971',
      'anonymname': 'cde',
    })).thenAnswer(
      (realInvocation) => Stream.fromFuture(
        Future.value(
          HttpResponseEntity<MapEntity>.fromJson(
            json.decode(failedResponse),
          ),
        ),
      ),
    );

    when(netUtil.modifyAnonymous({
      'phonenumber': '13666279971',
      'anonymname': 'ghi',
    })).thenAnswer(
      (realInvocation) => Stream.fromFuture(
        Future.value(
          HttpResponseEntity<MapEntity>.fromJson(
            json.decode(sessionInvalidResponse),
          ),
        ),
      ),
    );
  }

  testWidgets('PersonalInformationPage', (WidgetTester tester) async {
    mockInitSuccessResponse();

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

  testWidgets('modifyAnonymous', (WidgetTester tester) async {
    // 修改成功
    mockInitSuccessResponse();

    await showWidget(tester, PersonalInformationPage());

    mockModifyAnonymousResponse();

    await tap(tester, find.text('修改匿名'));
    await tester.enterText(find.byType(TextField), 'asd');
    await tap(tester, find.text('确认'));

    expect(find.text('我的匿名：asd'), findsOneWidget);

    await tap(tester, find.text('修改匿名'));
    await tester.enterText(find.byType(TextField), 'cde');
    await tap(tester, find.text('确认'));

    expect(find.text('我的匿名：cde'), findsNothing);

    await tap(tester, find.text('修改匿名'));
    await tester.enterText(find.byType(TextField), 'ghi');
    await tap(tester, find.text('确认'));

    expect(find.text('我的匿名：ghi'), findsNothing);
  });
}
