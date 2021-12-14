///
/// my_post_page_test
///
/// created by DZDcyj at 2021/12/14
///
import 'dart:async';
import 'dart:convert';

import 'package:dartin/dartin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:xianren_app/bean/bean.dart';
import 'package:xianren_app/page/homepage/view/personal_information/my_post_page.dart';
import 'package:xianren_app/utils/net_util.dart';

import '../base/app_module.dart';
import '../base/base.dart';
import '../base/data.dart';

void main() {
  init();

  NetUtil netUtil = inject();

  void mockResponse() {
    when(netUtil.getUserPosts(1)).thenAnswer(
      (realInvocation) => Stream.fromFuture(
        Future.value(
          HttpResponseEntity<PostListEntity>.fromJson(
            json.decode(postsResponse),
          ),
        ),
      ),
    );

    when(netUtil.getUserPosts(2)).thenAnswer(
      (realInvocation) => Stream.fromFuture(
        Future.value(
          HttpResponseEntity<PostListEntity>.fromJson(
            json.decode(emptyPostsResponse),
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

  testWidgets('MyPostPage', (WidgetTester tester) async {
    await showWidget(tester, MyPostPage());

    await tester.drag(find.byType(ElevatedButton).first, Offset(0.0, 500.0));
    await tester.pump();
    await tester.pump(Duration(seconds: 3));

    await tester.drag(find.byType(ElevatedButton).last, Offset(0.0, -1500.0));
    await tester.pump();
    await tester.pump(Duration(seconds: 3));
  });
}
