///
/// post_detail_test
///
/// created by DZDcyj at 2021/12/12
///
import 'dart:async';
import 'dart:convert';

import 'package:dartin/dartin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:xianren_app/bean/bean.dart';
import 'package:xianren_app/page/homepage/view/tree_hole/post_detail.dart';
import 'package:xianren_app/utils/net_util.dart';

import '../base/app_module.dart';
import '../base/base.dart';
import '../base/data.dart';

void main() {
  init();

  NetUtil netUtil = inject();

  tearDown(() {
    reset(netUtil);
  });

  testWidgets('PostDetail', (WidgetTester tester) async {
    when(netUtil.getPostDetail(8)).thenAnswer(
      (realInvocation) => Stream.fromFuture(
        Future.value(
          HttpResponseEntity<PostDetailEntity>.fromJson(
            json.decode(postDetailResponse),
          ),
        ),
      ),
    );

    when(netUtil.getComments(8, 1)).thenAnswer(
      (realInvocation) => Stream.fromFuture(
        Future.value(
          HttpResponseEntity<CommentListEntity>.fromJson(
            json.decode(commentsResponse),
          ),
        ),
      ),
    );
    await showWidget(tester, PostDetail(8));

    await tester.drag(find.byType(Text).first, Offset(0.0, 500.0));
    await tester.pump();
    await tester.pump(Duration(seconds: 3));
  });

  testWidgets('PostDetail', (WidgetTester tester) async {
    when(netUtil.getPostDetail(8)).thenAnswer(
      (realInvocation) => Stream.fromFuture(
        Future.value(
          HttpResponseEntity<PostDetailEntity>.fromJson(
            json.decode(postDetailResponse),
          ),
        ),
      ),
    );

    when(netUtil.getComments(8, 1)).thenAnswer(
      (realInvocation) => Stream.fromFuture(
        Future.value(
          HttpResponseEntity<CommentListEntity>.fromJson(
            json.decode(commentsResponse),
          ),
        ),
      ),
    );

    when(netUtil.postNewComment(any)).thenAnswer(
      (realInvocation) => Stream.fromFuture(
        Future.value(
          HttpResponseEntity<MapEntity>.fromJson(
            json.decode(successResponse),
          ),
        ),
      ),
    );

    await showWidget(tester, PostDetail(8));

    await tap(tester, find.text('发布'));
    await tester.enterText(find.byType(TextField), 'asd');
    await tap(tester, find.text('发布'));
  });
}
