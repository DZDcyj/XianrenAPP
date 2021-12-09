///
/// tree_hole_page_test
///
/// created by DZDcyj at 2021/12/9
///
import 'dart:async';
import 'dart:convert';

import 'package:dartin/dartin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:xianren_app/bean/bean.dart';
import 'package:xianren_app/page/homepage/view/tree_hole/post_item.dart';
import 'package:xianren_app/page/homepage/view/tree_hole/tree_hole_page.dart';
import 'package:xianren_app/utils/net_util.dart';

import '../base/app_module.dart';
import '../base/base.dart';
import '../base/data.dart';

void main() {
  init();

  NetUtil netUtil = inject();

  void mockResponse() {
    when(netUtil.getPosts(1)).thenAnswer(
      (realInvocation) => Stream.fromFuture(
        Future.value(
          HttpResponseEntity<PostListEntity>.fromJson(
            json.decode(postsResponse),
          ),
        ),
      ),
    );
  }

  setUp(() {
    mockResponse();
  });

  tearDown(() {
    reset(netUtil);
  });

  testWidgets('TreeHolePage', (WidgetTester tester) async {
    await showWidget(tester, TreeHolePage());

    await tester.drag(find.byType(ElevatedButton).first, Offset(0.0, 500.0));
    await tester.pump();
    await tester.pump(Duration(seconds: 3));

    await tap(tester, find.byType(PostItem).first);
  });
}
