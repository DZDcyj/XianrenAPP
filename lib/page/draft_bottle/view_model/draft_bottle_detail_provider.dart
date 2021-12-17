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

  /// 正在加载
  bool _loading;

  bool get loading => _loading ?? true;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  /// 瓶子本身的内容
  String _bottleContent;

  String get bottleContent => _bottleContent ?? '';

  set bottleContent(String value) {
    _bottleContent = value;
    notifyListeners();
  }

  /// 评论列表
  List<String> _comments;

  List<String> get comments => _comments ?? [];

  set comments(List<String> value) {
    _comments = value;
    notifyListeners();
  }

  /// 新评论内容
  String comment;

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
        if (response.code == responseOK) {
          _updateBottleInfo(response.data);
        }
        onFinished?.call();
      },
    );
  }

  /// 更新瓶子信息
  void _updateBottleInfo(DraftBottleEntity entity) {
    bottleContent = entity.content;
    comments = entity.comments;
  }

  /// 验证评论是否为空
  bool validateComment({
    DataCallback callback,
  }) {
    if (comment?.isEmpty ?? true) {
      callback?.call('评论不能为空');
      return false;
    }
    return true;
  }

  /// 添加漂流瓶评论
  void commentBottle({
    VoidCallback onStart,
    VoidCallback onFinished,
    DataCallback onData,
  }) {
    onStart?.call();
    asyncRequest(
      netUtil.commentBottle(id, comment),
      onData: (response) {
        onData?.call(response);
        onFinished?.call();
      },
    );
  }
}
