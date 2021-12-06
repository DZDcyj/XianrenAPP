///
/// home_page_test
///
/// created by DZDcyj at 2021/11/28
///
import 'dart:async';
import 'dart:convert';

import 'package:dartin/dartin.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:xianren_app/bean/bean.dart';
import 'package:xianren_app/page/homepage/view/homepage.dart';
import 'package:xianren_app/utils/net_util.dart';

import '../base/app_module.dart';
import '../base/base.dart';
import '../base/data.dart';

void main() {
  init();

  NetUtil netUtil = inject();

  testWidgets('HomePage', (WidgetTester tester) async {
    // 进入时需要令载入环节结束
    when(netUtil.getAllInfo()).thenAnswer(
      (realInvocation) => Stream.fromFuture(
        Future.value(
          HttpResponseEntity<UserInformationEntity>.fromJson(
            json.decode(successInfoResponse),
          ),
        ),
      ),
    );
    await showWidget(tester, HomePage());

    await tap(tester, find.text('小纸条'));
    expect(find.text('You are now at page 0'), findsOneWidget);
  });
}
