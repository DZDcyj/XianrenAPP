///
/// draft_bottle_page_test
///
/// created by DZDcyj at 2021/12/16
///
import 'dart:convert';

import 'package:dartin/dartin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:xianren_app/bean/bean.dart';
import 'package:xianren_app/page/draft_bottle/view/draft_bottle_page.dart';
import 'package:xianren_app/utils/net_util.dart';

import '../base/app_module.dart';
import '../base/base.dart';
import '../base/data.dart';

void main() {
  init();

  NetUtil netUtil = inject();

  tearDown(() => reset(netUtil));

  testWidgets('DraftBottlePage', (WidgetTester tester) async {
    when(netUtil.throwBottle(any)).thenAnswer(
      (realInvocation) => Stream.fromFuture(
        Future.value(
          HttpResponseEntity<MapEntity>.fromJson(
            json.decode(successResponse),
          ),
        ),
      ),
    );
    await showWidget(tester, DraftBottlePage());

    await tap(tester, find.byType(IconButton).first);
    await tester.enterText(find.byType(TextField), 'asd');
    await tap(tester, find.text('确认'));
  });
}
