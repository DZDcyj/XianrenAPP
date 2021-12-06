///
/// net_util
///
/// created by DZDcyj at 2021/11/28
///
import 'dart:async';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:xianren_app/bean/bean.dart';
import 'package:xianren_app/constants/constants.dart';

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
    var response = await dio.get(url, queryParameters: queryParameters);
    debugPrint('Get response from $url: ${response.data}');
    return HttpResponseEntity<T>.fromJson(response.data);
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
    var response = await dio.post(url, data: data, queryParameters: queryParameters);
    debugPrint('Post to $url, get response ${response.data}');
    return HttpResponseEntity<T>.fromJson(response.data);
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
