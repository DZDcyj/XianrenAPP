///
/// draft_bottle_detail_test
///
/// created by DZDcyj at 2021/12/16
///
import 'dart:convert';

import 'package:dartin/dartin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:xianren_app/bean/bean.dart';
import 'package:xianren_app/page/draft_bottle/view/draft_bottle_detail.dart';
import 'package:xianren_app/utils/net_util.dart';

import '../base/app_module.dart';
import '../base/base.dart';
import '../base/data.dart';

void main() {
  init();
  NetUtil netUtil = inject();
  tearDown(() => reset(netUtil));

  testWidgets('description', (WidgetTester tester) async {
    when(netUtil.getBottleDetail(123)).thenAnswer(
      (realInvocation) => Stream.fromFuture(
        Future.value(
          HttpResponseEntity<DraftBottleEntity>.fromJson(
            json.decode(bottleDetailResponse),
          ),
        ),
      ),
    );
    await showWidget(tester, DraftBottleDetail(123));

    when(netUtil.commentBottle(123, 'asd')).thenAnswer(
      (realInvocation) => Stream.fromFuture(
        Future.value(
          HttpResponseEntity<MapEntity>.fromJson(
            json.decode(successResponse),
          ),
        ),
      ),
    );
    await tester.enterText(find.byType(TextField), 'asd');
    await tap(tester, find.text('发布'));
  });
}
