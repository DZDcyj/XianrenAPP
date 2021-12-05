///
/// personal_information_page_test
///
/// created by DZDcyj at 2021/11/30
///
import 'dart:async';
import 'dart:convert';

import 'package:dartin/dartin.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:xianren_app/bean/bean.dart';
import 'package:xianren_app/page/homepage/view/personal_information_page.dart';
import 'package:xianren_app/utils/net_util.dart';

import '../base/app_module.dart';
import '../base/base.dart';
import '../base/data.dart';

void main() {
  init();

  NetUtil netUtil = inject();

  testWidgets('PersonalInformationPage', (WidgetTester tester) async {
    when(netUtil.getAllInfo()).thenAnswer(
      (realInvocation) => Stream.fromFuture(
        Future.value(
          HttpResponseEntity<UserInformationEntity>.fromJson(
            json.decode(successInfoResponse),
          ),
        ),
      ),
    );

    await showWidget(tester, PersonalInformationPage());
  });
}
