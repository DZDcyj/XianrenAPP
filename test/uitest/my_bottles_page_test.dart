///
/// my_bottles_page_test
///
/// created by DZDcyj at 2021/12/16
///
import 'dart:convert';

import 'package:dartin/dartin.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:xianren_app/bean/bean.dart';
import 'package:xianren_app/page/draft_bottle/view/draft_bottle_item.dart';
import 'package:xianren_app/page/draft_bottle/view/my_bottles_page.dart';
import 'package:xianren_app/utils/net_util.dart';

import '../base/app_module.dart';
import '../base/base.dart';
import '../base/data.dart';

void main() {
  init();

  NetUtil netUtil = inject();

  tearDown(() => reset(netUtil));

  testWidgets('MyBottlesPage', (WidgetTester tester) async {
    when(netUtil.getUserBottles(1)).thenAnswer(
      (realInvocation) => Stream.fromFuture(
        Future.value(
          HttpResponseEntity<DraftBottleListEntity>.fromJson(
            json.decode(bottleResponse),
          ),
        ),
      ),
    );
    await showWidget(tester, MyBottlesPage());

    await tap(tester, find.byType(DraftBottleItem).first);

    await tester.drag(find.byType(DraftBottleItem).first, Offset(0.0, 500.0));
    await tester.pump();
    await tester.pump(Duration(seconds: 3));
  });
}
