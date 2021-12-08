///
/// register_page_test
///
/// created by DZDcyj at 2021/11/30
///
import 'dart:async';
import 'dart:convert';

import 'package:dartin/dartin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:xianren_app/bean/bean.dart';
import 'package:xianren_app/page/login_page/view/register_page.dart';
import 'package:xianren_app/utils/global_util.dart';
import 'package:xianren_app/utils/net_util.dart';
import 'package:xianren_app/utils/string_util.dart';

import '../base/app_module.dart';
import '../base/base.dart';
import '../base/data.dart';

void main() {
  init();

  NetUtil netUtil = inject();

  testWidgets('RegisterPage', (WidgetTester tester) async {
    RegisterPage page = RegisterPage();
    await showWidget(tester, page);

    // 输入信息
    await tester.enterText(find.byType(TextField).first, 'asd');
    expect(page.mProvider.nickName, 'asd');
    await tester.enterText(find.byType(TextField).at(1), '13384581839');
    expect(page.mProvider.phone, '13384581839');
    await tester.enterText(find.byType(TextField).at(2), 'ABCDefgh1234');
    expect(page.mProvider.password, 'ABCDefgh1234');
    await tester.enterText(find.byType(TextField).at(3), 'ghij');
    expect(page.mProvider.realName, 'ghij');
    await tester.enterText(find.byType(TextField).at(4), 'klmn');
    expect(page.mProvider.studentId, 'klmn');
    await tester.enterText(find.byType(TextField).at(5), '440102198001021230');
    expect(page.mProvider.idNumber, '440102198001021230');

    // 点击测试
    // 隐藏生日
    await tap(tester, find.byType(CheckboxListTile));
    expect(page.mProvider.birthdayHidden, true);
    await tap(tester, find.text(transferDate(page.mProvider.birthday)));
    await tap(tester, find.text('确定'));
    expect(transferDate(page.mProvider.birthday), transferDate(DateTime.now()));

    // 选择性别
    await tap(tester, find.byType(DropdownButton));
    await tap(tester, find.byType(DropdownMenuItem).last);
    expect(page.mProvider.gender, Gender.secret);

    when(netUtil.register(any)).thenAnswer(
      (realInvocation) => Stream.fromFuture(
        Future.value(
          HttpResponseEntity<MapEntity>.fromJson(
            json.decode(successResponse),
          ),
        ),
      ),
    );
    await tap(tester, find.byType(ElevatedButton));
  });
}
