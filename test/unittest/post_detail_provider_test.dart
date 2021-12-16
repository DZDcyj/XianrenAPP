///
/// post_detail_provider_test
///
/// created by DZDcyj at 2021/12/14
///
import 'dart:convert';

import 'package:dartin/dartin.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:xianren_app/bean/bean.dart';
import 'package:xianren_app/page/tree_hole/view_model/post_detail_provider.dart';
import 'package:xianren_app/utils/net_util.dart';

import '../base/app_module.dart';
import '../base/data.dart';

void main() {
  init();

  NetUtil netUtil = inject();

  void mockResponses() {
    when(netUtil.getPostDetail(123)).thenAnswer(
      (realInvocation) => Stream.fromFuture(
        Future.value(
          HttpResponseEntity<PostDetailEntity>.fromJson(
            json.decode(postDetailResponse),
          ),
        ),
      ),
    );

    when(netUtil.getComments(123, 1)).thenAnswer(
      (realInvocation) => Stream.fromFuture(
        Future.value(
          HttpResponseEntity<CommentListEntity>.fromJson(
            json.decode(commentsResponse),
          ),
        ),
      ),
    );

    when(netUtil.getComments(123, 2)).thenAnswer(
      (realInvocation) => Stream.fromFuture(
        Future.value(
          HttpResponseEntity<CommentListEntity>.fromJson(
            json.decode(commentsResponse),
          ),
        ),
      ),
    );
  }

  PostDetailProvider provider;

  setUp(() {
    provider = PostDetailProvider(123);
    mockResponses();
  });

  tearDown(() {
    reset(netUtil);
  });

  test('loadingMoreComments', () {
    expect(provider.loadingMoreComments, false);
    provider.loadingMoreComments = true;
    expect(provider.loadingMoreComments, true);
  });

  test('getPostContent', () {
    bool success = false;
    provider.getPostContent(
      onData: (response) {
        success = true;
      },
      onFinished: () => expect(success, true),
    );
  });

  test('getComments', () {
    bool success = false;
    provider.getComments(
      refresh: false,
      onData: (response) {
        success = true;
      },
      onFinished: () => expect(success, true),
    );
  });

  test('validateComment', () {
    expect(provider.validateComment(callback: (message) {
      expect(message, '评论不能为空');
    }), false);
  });
}
