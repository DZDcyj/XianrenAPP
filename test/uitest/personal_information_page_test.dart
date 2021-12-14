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
import 'package:xianren_app/utils/global_util.dart';
import 'package:xianren_app/utils/net_util.dart';

import '../base/app_module.dart';
import '../base/base.dart';
import '../base/data.dart';

void main() {
  init();

  NetUtil netUtil = inject();

  void _resetUser() {
    reset(netUtil);
    Global.userInformationEntity = null;
  }

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
      'phonenumber': '12345678910',
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
      'phonenumber': '12345678910',
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
      'phonenumber': '12345678910',
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
    _resetUser();
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
    _resetUser();
  });

  testWidgets('PersonalInformationPage', (WidgetTester tester) async {
    // 成功
    mockInitSuccessResponse();

    await showWidget(tester, PersonalInformationPage());

    SharedPreferences.setMockInitialValues({
      'autoLogin': true,
    });

    await tap(tester, find.text('退出登录'));
    await tester.pumpAndSettle();
  });

  testWidgets('PersonalInformationPage', (WidgetTester tester) async {
    // 缓存路径测试
    mockInitSuccessResponse();

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
    await tap(tester, find.text('取消'));

    await tester.drag(find.byType(Image), Offset(0.0, 500.0));
    await tester.pump();
    await tester.pump(Duration(seconds: 3));

    // 请注意，执行下面的代码后，程序将退出到登录界面
    await tap(tester, find.text('修改匿名'));
    await tester.enterText(find.byType(TextField), 'ghi');
    await tap(tester, find.text('确认'));

    expect(find.text('我的匿名：ghi'), findsNothing);
    await tester.pumpAndSettle();
  });

  testWidgets('modifyUserInformation', (WidgetTester tester) async {
    mockInitSuccessResponse();
    PersonalInformationPage page = PersonalInformationPage();
    await showWidget(tester, page);

    page.mProvider.refreshTimestamp = DateTime.now().add(Duration(seconds: 100)).millisecondsSinceEpoch;
    await tester.drag(find.byType(Image), Offset(0.0, 500.0));
    await tester.pump();
    await tester.pump(Duration(seconds: 3));
  });

  /// 模拟修改后请求数据
  void mockModifiedResponse() {
    when(netUtil.modifyPersonalInformation({
      'phonenumber': '12345678910',
      'gender': '男',
      'birthday': '2005-11-14',
      'boolhidebirthday': 1,
    })).thenAnswer(
      (realInvocation) => Stream.fromFuture(
        Future.value(
          HttpResponseEntity<MapEntity>.fromJson(
            json.decode(successResponse),
          ),
        ),
      ),
    );

    when(netUtil.modifyPersonalInformation({
      'phonenumber': '12345678910',
      'gender': '男',
      'birthday': '2005-11-14',
      'boolhidebirthday': 0,
    })).thenAnswer(
      (realInvocation) => Stream.fromFuture(
        Future.value(
          HttpResponseEntity<MapEntity>.fromJson(
            json.decode(failedResponse),
          ),
        ),
      ),
    );

    when(netUtil.modifyPersonalInformation({
      'phonenumber': '12345678910',
      'gender': '男',
      'nickname': 'asd',
      'birthday': '2005-11-14',
      'boolhidebirthday': 1,
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

  testWidgets('PersonalInformationModifyPage', (WidgetTester tester) async {
    reset(netUtil);
    mockInitSuccessResponse();
    PersonalInformationPage page = PersonalInformationPage();
    mockModifiedResponse();
    await showWidget(tester, page);
    await tap(tester, find.text('修改个人信息'));
    await tester.pumpAndSettle();
    await tap(tester, find.text('确认修改'));
    await tester.pumpAndSettle();

    await tap(tester, find.text('修改个人信息'));
    await tester.pumpAndSettle();
    await tap(tester, find.text('隐藏生日'));
    await tap(tester, find.text('确认修改'));
    await tester.pumpAndSettle();

    await tap(tester, find.text('修改个人信息'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'asd');
    await tap(tester, find.text('确认修改'));
    await tester.pumpAndSettle();
  });
}
