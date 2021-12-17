///
/// draft_bottle_page_provider
///
/// created by DZDcyj at 2021/12/15
///
import 'package:dartin/dartin.dart';
import 'package:xianren_app/base/view_model/base_page_view_provider.dart';
import 'package:xianren_app/constants/constants.dart';
import 'package:xianren_app/utils/net_util.dart';

class DraftBottlePageProvider extends BasePageProvider {
  NetUtil netUtil = inject();

  /// 捞瓶子
  void scoopBottle({
    VoidCallback onStart,
    VoidCallback onFinished,
    FutureDataCallBack onData,
  }) {
    onStart?.call();
    asyncRequest(
      netUtil.scoopBottle(),
      onData: (response) {
        onData?.call(response)?.then((value) => onFinished?.call());
      },
    );
  }

  /// 扔瓶子
  void throwBottle(
    String content, {
    VoidCallback onStart,
    VoidCallback onFinished,
    DataCallback onData,
  }) {
    onStart?.call();
    asyncRequest(
      netUtil.throwBottle(content),
      onData: (response) {
        onData?.call(response);
        onFinished?.call();
      },
    );
  }

  /// 收集瓶子
  void collectBottle(
    int id, {
    VoidCallback onStart,
    VoidCallback onFinished,
    DataCallback onData,
  }) {
    onStart?.call();
    asyncRequest(
      netUtil.collectBottle(id),
      onData: (response) {
        onData?.call(response);
        onFinished?.call();
      },
    );
  }

  /// 销毁瓶子
  void destroyBottle(
    int id, {
    VoidCallback onStart,
    VoidCallback onFinished,
    DataCallback onData,
  }) {
    onStart?.call();
    asyncRequest(
      netUtil.destroyBottle(id),
      onData: (response) {
        onData?.call(response);
        onFinished?.call();
      },
    );
  }
}
