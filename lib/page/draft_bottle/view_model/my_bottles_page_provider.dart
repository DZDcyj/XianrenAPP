///
/// my_bottles_page_provider
///
/// created by DZDcyj at 2021/12/16
///
import 'package:dartin/dartin.dart';
import 'package:xianren_app/base/view_model/base_page_view_provider.dart';
import 'package:xianren_app/bean/bean.dart';
import 'package:xianren_app/constants/constants.dart';
import 'package:xianren_app/utils/net_util.dart';

class MyBottlesPageProvider extends BasePageProvider {
  NetUtil netUtil = inject();

  List<DraftBottleEntity> bottles = [];

  bool _loading;

  bool get loading => _loading ?? true;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  /// 加载更多
  bool _loadingMore;

  bool get loadingMore => _loadingMore ?? false;

  set loadingMore(bool value) {
    _loadingMore = value;
    notifyListeners();
  }

  bool _hasMore;

  /// 是否有更多
  bool get hasMore => _hasMore ?? true;

  set hasMore(bool value) {
    _hasMore = value;
    notifyListeners();
  }

  /// 页码
  int _pageIndex;

  int get pageIndex => _pageIndex ?? 1;

  set pageIndex(int value) {
    _pageIndex = value;
    notifyListeners();
  }

  /// 获取所有瓶子
  void getAllBottles(
    bool refresh, {
    VoidCallback onStart,
    VoidCallback onFinished,
    DataCallback onData,
  }) {
    onStart?.call();
    asyncRequest(
      netUtil.getUserBottles(refresh ? 1 : pageIndex + 1),
      onData: (response) {
        onData?.call(response);
        _updateBottles(response.data, refresh);
        onFinished?.call();
      },
    );
  }

  /// 更新信息
  void _updateBottles(DraftBottleListEntity entity, bool refresh) {
    if (refresh) {
      bottles = entity.bottles;
      pageIndex = 1;
      hasMore = true;
      return;
    }
    pageIndex++;
    var newList = bottles;
    newList.addAll(entity.bottles);
    bottles = newList;
  }

  /// 丢瓶子回去
  void throwBackBottle(
    int id, {
    VoidCallback onStart,
    VoidCallback onFinished,
    DataCallback onData,
  }) {
    onStart?.call();
    asyncRequest(
      netUtil.throwCollectedBottle(id),
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
