///
/// net_util_test
///
/// created by DZDcyj at 2021/11/28
///
import 'dart:convert';

import 'package:dartin/dartin.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:xianren_app/bean/bean.dart';
import 'package:xianren_app/constants/constants.dart';
import 'package:xianren_app/utils/net_util.dart';

import '../base/app_module.dart';
import '../base/data.dart';

void main() {
  init();

  NetUtil netUtil = inject();

  void mockGetData() {
    when(netUtil.get<MapEntity>(any)).thenAnswer(
      (realInvocation) => Stream.fromFuture(
        Future.value(
          HttpResponseEntity<MapEntity>.fromJson(
            json.decode(successResponse),
          ),
        ),
      ),
    );
  }

  test('get', () {
    mockGetData();

    netUtil.get('api').listen((response) {
      expect(response.code, responseOK);
      expect(response.msg, 'success');
      expect(response.rawData is Map, true);
      expect(response.data is MapEntity, true);
    });
  });

  test('constructUrl', () {
    expect(constructUrl('api'), 'https://api.chinsan.top/api');
  });
}
