///
/// draft_bottle_page_provider
///
/// created by DZDcyj at 2021/12/15
///
import 'package:dartin/dartin.dart';
import 'package:flutter/cupertino.dart';
import 'package:xianren_app/base/view_model/base_page_view_provider.dart';
import 'package:xianren_app/constants/constants.dart';
import 'package:xianren_app/utils/net_util.dart';

class DraftBottlePageProvider extends BasePageProvider {
  NetUtil netUtil = inject();

  /// 捞瓶子
  void scoopBottles({
    VoidCallback onStart,
    VoidCallback onFinished,
    DataCallback onData,
  }) {
    onStart?.call();
    asyncRequest(
      netUtil.scoopBottles(),
      onData: (response) {
        onData?.call(response);
        onFinished?.call();
      },
    );
  }
}
