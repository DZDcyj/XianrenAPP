///
/// login_page_test
///
/// created by DZDcyj at 2021/11/28
///
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xianren_app/page/login_page/view/login_page.dart';

import '../base/app_module.dart';
import '../base/base.dart';

void main() {
  init();

  testWidgets('LoginPage', (WidgetTester tester) async {
    LoginPage page = LoginPage();
    await showWidget(tester, page, duration: Duration(seconds: 1));

    // 检查元素数量
    expect(find.text('Xianren'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.byType(CheckboxListTile), findsNWidgets(2));
    expect(find.byType(Image), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);

    // 检查输入
    await tester.enterText(find.byType(TextField).first, 'asd');
    expect(page.mProvider.username, 'asd');
    await tester.enterText(find.byType(TextField).last, 'efg');
    expect(page.mProvider.password, 'efg');

    // 检查复选框
    var autoInput = find.byType(CheckboxListTile).first;
    var autoLogin = find.byType(CheckboxListTile).last;

    // 点击情况测试
    await tap(tester, autoInput);
    expect(page.mProvider.autoInput, true);
    await tap(tester, autoLogin);
    expect(page.mProvider.autoLogin, true);
    await tap(tester, autoInput);
    expect(page.mProvider.autoInput, false);
    expect(page.mProvider.autoLogin, false);
    await tap(tester, autoLogin);
    expect(page.mProvider.autoInput, true);
    expect(page.mProvider.autoLogin, true);

    // TODO: test login func
    // await tap(tester, find.byType(ElevatedButton));
  });

  testWidgets('SharedPreferences', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({
      'username': 'mockUsername',
      'password': 'mockPassword',
      'autoLogin': true,
      'autoInput': true,
    });
    await showWidget(tester, LoginPage(), duration: Duration(seconds: 1));

    expect(
      find.byWidgetPredicate((widget) => widget is TextField && widget.controller.text == 'mockUsername'),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate((widget) => widget is TextField && widget.controller.text == 'mockPassword'),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
          (widget) => widget is CheckboxListTile && (widget.title as Text).data == '记住手机号密码' && widget.value),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
          (widget) => widget is CheckboxListTile && (widget.title as Text).data == '自动登录' && widget.value),
      findsOneWidget,
    );
  });
}
