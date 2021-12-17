///
/// my_bottles_page_provider_test
///
/// created by DZDcyj at 2021/12/16
///
import 'dart:convert';

import 'package:dartin/dartin.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:xianren_app/bean/bean.dart';
import 'package:xianren_app/constants/constants.dart';
import 'package:xianren_app/page/draft_bottle/view_model/my_bottles_page_provider.dart';
import 'package:xianren_app/utils/net_util.dart';

import '../base/app_module.dart';
import '../base/data.dart';

void main() {
  init();

  NetUtil netUtil = inject();

  MyBottlesPageProvider provider;

  setUp(() => provider = MyBottlesPageProvider());

  test('loadingMore', () {
    expect(provider.loadingMore, false);
    provider.loadingMore = true;
    expect(provider.loadingMore, true);
  });

  test('pageIndex', () {
    expect(provider.pageIndex, 1);
    provider.pageIndex = 3;
    expect(provider.pageIndex, 3);
  });

  test('throwBackBottle', () {
    when(netUtil.throwCollectedBottle(any)).thenAnswer(
      (realInvocation) => Stream.fromFuture(
        Future.value(
          HttpResponseEntity<MapEntity>.fromJson(
            json.decode(successResponse),
          ),
        ),
      ),
    );

    bool success = false;
    provider.throwBackBottle(
      123,
      onData: (response) {
        if (response.code == responseOK) {
          success = true;
        }
      },
      onFinished: () => expect(success, true),
    );
  });

  test('destroyBottle', () {
    when(netUtil.destroyBottle(any)).thenAnswer(
      (realInvocation) => Stream.fromFuture(
        Future.value(
          HttpResponseEntity<MapEntity>.fromJson(
            json.decode(successResponse),
          ),
        ),
      ),
    );

    bool success = false;
    provider.destroyBottle(
      123,
      onData: (response) {
        if (response.code == responseOK) {
          success = true;
        }
      },
      onFinished: () => expect(success, true),
    );
  });

  test('getAllBottles', () {
    when(netUtil.getUserBottles(any)).thenAnswer(
      (realInvocation) => Stream.fromFuture(
        Future.value(
          HttpResponseEntity<DraftBottleListEntity>.fromJson(
            json.decode(bottleResponse),
          ),
        ),
      ),
    );

    provider.getAllBottles(
      false,
      onFinished: () => expect(provider.pageIndex, 2),
    );
  });
}
