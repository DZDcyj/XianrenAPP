///
/// personal_information_modify_page_test
///
/// created by DZDcyj at 2021/12/7
///
import 'dart:convert';

import 'package:dartin/dartin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:xianren_app/bean/bean.dart';
import 'package:xianren_app/page/homepage/view/personal_information/personal_information_modify_page.dart';
import 'package:xianren_app/utils/global_util.dart';
import 'package:xianren_app/utils/net_util.dart';

import '../base/app_module.dart';
import '../base/base.dart';
import '../base/data.dart';

void main() {
  init();

  NetUtil netUtil = inject();

  testWidgets('PersonalInformationModifyPage', (WidgetTester tester) async {
    await showWidget(
      tester,
      PersonalInformationModifyPage(
        '1234',
        DateTime(2000),
        Gender.secret,
        true,
        (value) {},
      ),
    );
    when(netUtil.modifyPersonalInformation({
      'phonenumber': '1234',
      'nickname': 'asd',
      'gender': '不便透露',
      'birthday': '2000-01-01',
      'boolhidebirthday': 1,
    })).thenAnswer(
      (realInvocation) => Stream.fromFuture(
        Future.value(
          HttpResponseEntity<MapEntity>.fromJson(
            json.decode(successInfoResponse),
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextField), 'asd');
    await tap(tester, find.text('确认修改'));
  });

  testWidgets('PersonalInformationModifyPage', (WidgetTester tester) async {
    when(netUtil.modifyPersonalInformation({
      'phonenumber': '1234',
      'gender': '不便透露',
      'birthday': '2000-01-01',
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
    await showWidget(
      tester,
      PersonalInformationModifyPage(
        '1234',
        DateTime(2000),
        Gender.secret,
        true,
        (value) {},
      ),
    );

    await tap(tester, find.text('2000-01-01'));
    await tap(tester, find.text('确定'));

    await tap(tester, find.text('隐藏生日'));
    await tap(tester, find.text('不便透露'));
    await tap(tester, find.byType(DropdownMenuItem).last);

    await tap(tester, find.text('确认修改'));
  });
}
