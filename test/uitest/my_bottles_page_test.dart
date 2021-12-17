///
/// my_bottles_page_test
///
/// created by DZDcyj at 2021/12/16
///
import 'dart:convert';

import 'package:dartin/dartin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:xianren_app/bean/bean.dart';
import 'package:xianren_app/page/draft_bottle/view/draft_bottle_item.dart';
import 'package:xianren_app/page/draft_bottle/view/my_bottles_page.dart';
import 'package:xianren_app/utils/net_util.dart';

import '../base/app_module.dart';
import '../base/base.dart';
import '../base/data.dart';

void main() {
  init();

  NetUtil netUtil = inject();

  tearDown(() => reset(netUtil));

  testWidgets('MyBottlesPage', (WidgetTester tester) async {
    when(netUtil.getUserBottles(1)).thenAnswer(
      (realInvocation) => Stream.fromFuture(
        Future.value(
          HttpResponseEntity<DraftBottleListEntity>.fromJson(
            json.decode(bottleResponse),
          ),
        ),
      ),
    );

    when(netUtil.getUserBottles(2)).thenAnswer(
      (realInvocation) => Stream.fromFuture(
        Future.value(
          HttpResponseEntity<DraftBottleListEntity>.fromJson(
            json.decode(emptyCommentsResponse),
          ),
        ),
      ),
    );
    await showWidget(tester, MyBottlesPage());

    await tap(tester, find.byType(DraftBottleItem).first);

    await tester.drag(find.byType(DraftBottleItem).first, Offset(0.0, 500.0));
    await tester.pump();
    await tester.pump(Duration(seconds: 3));
  });

  testWidgets('MyBottlesPage', (WidgetTester tester) async {
    when(netUtil.getUserBottles(1)).thenAnswer(
      (realInvocation) => Stream.fromFuture(
        Future.value(
          HttpResponseEntity<DraftBottleListEntity>.fromJson(
            json.decode(bottleResponse),
          ),
        ),
      ),
    );

    when(netUtil.destroyBottle(any)).thenAnswer(
      (realInvocation) => Stream.fromFuture(
        Future.value(
          HttpResponseEntity<MapEntity>.fromJson(
            json.decode(successResponse),
          ),
        ),
      ),
    );

    when(netUtil.throwCollectedBottle(any)).thenAnswer(
      (realInvocation) => Stream.fromFuture(
        Future.value(
          HttpResponseEntity<MapEntity>.fromJson(
            json.decode(successResponse),
          ),
        ),
      ),
    );
    await showWidget(tester, MyBottlesPage());

    await tester.longPress(find.byType(DraftBottleItem).first);
    await tester.pump();
    await tester.pumpAndSettle();
    await tap(tester, find.text('销毁'));

    await tester.longPress(find.byType(DraftBottleItem).first);
    await tester.pump();
    await tester.pumpAndSettle();
    await tap(tester, find.text('扔回大海'));

    await tester.longPress(find.byType(DraftBottleItem).first);
    await tester.pump();
    await tester.pumpAndSettle();
    await tap(tester, find.text('什么也不做'));
  });
}
