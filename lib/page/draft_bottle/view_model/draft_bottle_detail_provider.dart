///
/// draft_bottle_detail_provider
///
/// created by DZDcyj at 2021/12/16
///
import 'package:dartin/dartin.dart';
import 'package:xianren_app/base/view_model/base_page_view_provider.dart';
import 'package:xianren_app/bean/bean.dart';
import 'package:xianren_app/constants/constants.dart';
import 'package:xianren_app/utils/net_util.dart';

class DraftBottleDetailProvider extends BasePageProvider {
  DraftBottleDetailProvider(this.id);

  final int id;

  NetUtil netUtil = inject();

  DraftBottleEntity entity;

  String content;

  /// 获取瓶子详细信息
  void getBottleDetail({
    VoidCallback onStart,
    VoidCallback onFinished,
    DataCallback onData,
  }) {
    onStart?.call();
    asyncRequest(
      netUtil.getBottleDetail(id),
      onData: (response) {
        onData?.call(response);
        if (response == responseOK) {
          entity = response.data;
        }
        onFinished?.call();
      },
    );
  }

  /// 添加漂流瓶评论
  void commentBottle({
    VoidCallback onStart,
    VoidCallback onFinished,
    DataCallback onData,
  }) {
    onStart?.call();
    asyncRequest(
      netUtil.commentBottle(id, content),
      onData: (response) {
        onData?.call(response);
        onFinished?.call();
      },
    );
  }
}
