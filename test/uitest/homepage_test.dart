///
/// home_page_test
///
/// created by DZDcyj at 2021/11/28
///
import 'dart:async';
import 'dart:convert';

import 'package:dartin/dartin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:xianren_app/bean/bean.dart';
import 'package:xianren_app/page/homepage/view/draft_bottle/draft_bottle_page.dart';
import 'package:xianren_app/page/homepage/view/homepage.dart';
import 'package:xianren_app/page/homepage/view/personal_information/personal_information_page.dart';
import 'package:xianren_app/page/homepage/view/tree_hole/tree_hole_page.dart';
import 'package:xianren_app/utils/net_util.dart';

import '../base/app_module.dart';
import '../base/base.dart';
import '../base/data.dart';

void main() {
  init();

  NetUtil netUtil = inject();

  testWidgets('HomePage', (WidgetTester tester) async {
    // 进入时需要令载入环节结束
    when(netUtil.getAllInfo()).thenAnswer(
      (realInvocation) => Stream.fromFuture(
        Future.value(
          HttpResponseEntity<UserInformationEntity>.fromJson(
            json.decode(successInfoResponse),
          ),
        ),
      ),
    );
    await showWidget(tester, HomePage());
    expect(find.byType(DraftBottlePage), findsOneWidget);

    await tap(tester, find.text('树洞'));
    expect(find.byType(TreeHolePage), findsOneWidget);

    await tap(tester, find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tap(tester, find.byType(Icon).first);

    await tap(tester, find.text('我的'));
    expect(find.byType(PersonalInformationPage), findsOneWidget);
  });
}
