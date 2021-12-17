///
/// new_post_page_test
///
/// created by DZDcyj at 2021/12/8
///
import 'dart:convert';

import 'package:dartin/dartin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:xianren_app/bean/bean.dart';
import 'package:xianren_app/page/tree_hole/view/new_post_page.dart';
import 'package:xianren_app/utils/net_util.dart';

import '../base/app_module.dart';
import '../base/base.dart';
import '../base/data.dart';

void main() {
  init();

  NetUtil netUtil = inject();

  testWidgets('NewPostPage', (WidgetTester tester) async {
    await showWidget(tester, NewPostPage('1234'));

    when(netUtil.publishNewPost(any)).thenAnswer(
      (realInvocation) => Stream.fromFuture(
        Future.value(
          HttpResponseEntity<MapEntity>.fromJson(
            json.decode(successInfoResponse),
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextField).first, 'asd');
    await tester.enterText(find.byType(TextField).last, 'asd');

    await tap(tester, find.byType(FloatingActionButton));
  });

  testWidgets('NewPostPage', (WidgetTester tester) async {
    await showWidget(tester, NewPostPage('1234'));

    await tester.enterText(find.byType(TextField).first, 'asd');

    await tap(tester, find.byType(Icon).first);
    await tap(tester, find.text('取消'));
    await tap(tester, find.byType(Icon).first);
    await tap(tester, find.text('确认'));
    await tester.pumpAndSettle();
  });

  testWidgets('NewPostPage', (WidgetTester tester) async {
    await showWidget(tester, NewPostPage('1234'));

    await tap(tester, find.byType(FloatingActionButton));
  });
}
