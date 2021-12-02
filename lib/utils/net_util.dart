///
/// net_util
///
/// created by DZDcyj at 2021/11/28
///
import 'dart:async';
import 'dart:convert';

import 'package:dartin/dartin.dart';
import 'package:dio/dio.dart';
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

  Dio dio = Dio(baseOptions);

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
    return HttpResponseEntity<T>.fromJson(json.decode(response.data));
  }

  Stream<HttpResponseEntity<T>> post<T extends ToJson>(
    String api, {
    Map<String, dynamic> queryParameters,
    Map<String, dynamic> data,
  }) {
    return _post(constructUrl(api), queryParameters: queryParameters, data: data).asStream().asBroadcastStream();
  }

  Future<HttpResponseEntity<T>> _post<T extends ToJson>(
    String url, {
    Map<String, dynamic> queryParameters,
    Map<String, dynamic> data,
  }) async {
    var response = await dio.post(url, data: data, queryParameters: queryParameters);
    return HttpResponseEntity<T>.fromJson(json.decode(response.data));
  }
}

NetUtil netUtil = inject();

Stream<HttpResponseEntity<MapEntity>> login(String phoneNumber, String password) => netUtil.post(loginApi, data: {
      'phonenumber': phoneNumber,
      'password': password,
    });

String constructUrl(
  String api, {
  bool useHttps = true,
}) {
  var prefix = 'http';
  if (useHttps ?? false) {
    prefix = 'https';
  }
  return '$prefix://$serverDomain/$api';
}
