///
/// net_util
///
/// created by DZDcyj at 2021/11/28
///
import 'dart:async';
import 'dart:convert';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:xianren_app/bean/bean.dart';
import 'package:xianren_app/constants/constants.dart';

var networkFailedResponse = '''
{
    "code": -1,
    "message": "网络连接出错，请检查网络设置",
    "data": {}
}
''';

class NetUtil {
  NetUtil();

  static final BaseOptions baseOptions = BaseOptions(
    connectTimeout: maxTimeout,
    receiveTimeout: maxTimeout,
    contentType: contentType,
    responseType: ResponseType.json,
  );

  Dio dio = Dio(baseOptions)..interceptors.add(CookieManager(CookieJar()));

  Stream<HttpResponseEntity<T>> get<T extends ToJson>(
    String api, {
    Map<String, dynamic> queryParameters,
  }) {
    return _get<T>(constructUrl(api), queryParameters: queryParameters).asStream().asBroadcastStream();
  }

  Future<HttpResponseEntity<T>> _get<T extends ToJson>(
    String url, {
    Map<String, dynamic> queryParameters,
  }) async {
    try {
      var response = await dio.get(url, queryParameters: queryParameters);
      debugPrint('Get response from $url: ${response.data}');
      return HttpResponseEntity<T>.fromJson(response.data);
    } catch (error) {
      debugPrint('Error Caught:${error.error}');
      return HttpResponseEntity<T>.fromJson(json.decode(networkFailedResponse));
    }
  }

  Stream<HttpResponseEntity<T>> post<T extends ToJson>(
    String api, {
    Map<String, dynamic> queryParameters,
    Map<String, dynamic> data,
  }) {
    return _post<T>(constructUrl(api), queryParameters: queryParameters, data: data).asStream().asBroadcastStream();
  }

  Future<HttpResponseEntity<T>> _post<T extends ToJson>(
    String url, {
    Map<String, dynamic> queryParameters,
    Map<String, dynamic> data,
  }) async {
    try {
      var response = await dio.post(url, data: data, queryParameters: queryParameters);
      debugPrint('Post to $url, get response ${response.data}');
      return HttpResponseEntity<T>.fromJson(response.data);
    } catch (error) {
      debugPrint('Error Caught:${error.error}');
      return HttpResponseEntity<T>.fromJson(json.decode(networkFailedResponse));
    }
  }

  Stream<HttpResponseEntity<T>> delete<T extends ToJson>(
    String api, {
    Map<String, dynamic> queryParameters,
    Map<String, dynamic> data,
  }) {
    return _delete<T>(constructUrl(api), queryParameters: queryParameters, data: data).asStream().asBroadcastStream();
  }

  Future<HttpResponseEntity<T>> _delete<T extends ToJson>(
    String url, {
    Map<String, dynamic> queryParameters,
    Map<String, dynamic> data,
  }) async {
    try {
      var response = await dio.delete(url, data: data, queryParameters: queryParameters);
      debugPrint('Send delete request to $url, get response ${response.data}');
      return HttpResponseEntity<T>.fromJson(response.data);
    } catch (error) {
      debugPrint('Error Caught:${error.error}');
      return HttpResponseEntity<T>.fromJson(json.decode(networkFailedResponse));
    }
  }

  Stream<HttpResponseEntity<MapEntity>> login(String phoneNumber, String password) {
    return post(
      loginApi,
      data: {
        'phonenumber': phoneNumber,
        'password': password,
      },
    );
  }

  Stream<HttpResponseEntity<MapEntity>> register(Map<String, dynamic> data) {
    return post(
      registerApi,
      data: data,
    );
  }

  Stream<HttpResponseEntity<UserInformationEntity>> getAllInfo() {
    return get(getAllInfoApi);
  }

  Stream<HttpResponseEntity<MapEntity>> modifyAnonymous(Map<String, dynamic> data) {
    return post(
      modifyAnonymousApi,
      data: data,
    );
  }

  Stream<HttpResponseEntity<MapEntity>> modifyPersonalInformation(Map<String, dynamic> data) {
    return post(
      modifyPersonalBasicInformationApi,
      data: data,
    );
  }

  Stream<HttpResponseEntity<MapEntity>> publishNewPost(Map<String, dynamic> data) {
    return post(
      publishNewPostApi,
      data: data,
    );
  }

  Stream<HttpResponseEntity<PostListEntity>> getPosts(int pageIndex) {
    return get(
      getTreeHoleArticlesApi,
      queryParameters: {
        'pageindex': pageIndex,
      },
    );
  }

  Stream<HttpResponseEntity<PostDetailEntity>> getPostDetail(int postId) {
    return get(
      getPostDetailApi,
      queryParameters: {
        'mid': postId,
      },
    );
  }

  Stream<HttpResponseEntity<MapEntity>> postNewComment(Map<String, dynamic> data) {
    return post(
      postNewCommentApi,
      data: data,
    );
  }

  Stream<HttpResponseEntity<CommentListEntity>> getComments(int postId, int commentPageIndex) {
    return get(
      getCommentsApi,
      queryParameters: {
        'mid': postId,
        'cpageindex': commentPageIndex,
      },
    );
  }

  Stream<HttpResponseEntity<PostListEntity>> getUserPosts(int pageIndex) {
    return get(
      getUserPostsApi,
      queryParameters: {
        'pageindex': pageIndex,
      },
    );
  }

  Stream<HttpResponseEntity<MapEntity>> deletePost(int postId) {
    return delete(
      deletePostApi,
      queryParameters: {
        'mid': postId,
      },
    );
  }

  Stream<HttpResponseEntity<DraftBottleEntity>> scoopBottle() {
    return get(scoopBottleApi);
  }

  Stream<HttpResponseEntity<DraftBottleListEntity>> getUserBottles(int pageIndex) {
    return get(
      collectedBottlesApi,
      queryParameters: {
        'pageNum': pageIndex,
      },
    );
  }

  Stream<HttpResponseEntity<DraftBottleEntity>> getBottleDetail(int bottleId) {
    return get(
      driftBottleApi,
      queryParameters: {
        'id': bottleId,
      },
    );
  }

  Stream<HttpResponseEntity<MapEntity>> throwBottle(String content) {
    return post(
      throwBottleApi,
      data: {
        'content': content,
      },
    );
  }

  Stream<HttpResponseEntity<MapEntity>> commentBottle(int bottleId, String content) {
    return post(
      commentBottleApi,
      data: {
        'id': bottleId,
        'content': content,
      },
    );
  }

  Stream<HttpResponseEntity<MapEntity>> collectBottle(int bottleId) {
    return post(
      collectBottleApi,
      data: {
        'id': bottleId,
      },
    );
  }

  Stream<HttpResponseEntity<MapEntity>> destroyBottle(int bottleId) {
    return post(
      destroyBottleApi,
      data: {
        'id': bottleId,
      },
    );
  }

  Stream<HttpResponseEntity<MapEntity>> throwCollectedBottle(int bottleId) {
    return post(
      throwCollectedBottleApi,
      data: {
        'id': bottleId,
      },
    );
  }
}

String constructUrl(
  String api, {
  bool useHttps = false,
}) {
  var prefix = 'http';
  if (useHttps ?? false) {
    prefix = 'https';
  }
  return '$prefix://$serverDomain/$api';
}
