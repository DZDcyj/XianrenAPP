///
/// post_detail_provider
///
/// created by DZDcyj at 2021/12/11
///
import 'package:dartin/dartin.dart';
import 'package:flutter/cupertino.dart';
import 'package:xianren_app/base/view_model/base_page_view_provider.dart';
import 'package:xianren_app/bean/bean.dart';
import 'package:xianren_app/constants/constants.dart';
import 'package:xianren_app/utils/global_util.dart';
import 'package:xianren_app/utils/net_util.dart';
import 'package:xianren_app/utils/string_util.dart';

class PostDetailProvider extends BasePageProvider {
  PostDetailProvider(this.id);

  NetUtil netUtil = inject();

  final int id;

  /// 载入楼主
  bool _loadingPoster;

  bool get loadingPoster => _loadingPoster ?? true;

  set loadingPoster(bool value) {
    _loadingPoster = value;
    notifyListeners();
  }

  /// 载入回复
  bool _loadingComments;

  bool get loadingComments => _loadingComments ?? true;

  set loadingComments(bool value) {
    _loadingComments = value;
    notifyListeners();
  }

  /// 载入更多回复
  bool _loadingMoreComments;

  bool get loadingMoreComments => _loadingMoreComments ?? false;

  set loadingMoreComments(bool value) {
    _loadingMoreComments = value;
    notifyListeners();
  }

  /// 是否有更多回复
  bool _hasMore;

  bool get hasMore => _hasMore ?? true;

  set hasMore(bool value) {
    _hasMore = value;
    notifyListeners();
  }

  /// 请求页码
  int _commentPageIndex;

  int get commentPageIndex => _commentPageIndex ?? 1;

  set commentPageIndex(int value) {
    _commentPageIndex = value;
    notifyListeners();
  }

  /// 发表的评论
  String comment;

  PostDetailEntity postDetailEntity;

  /// 评论列表
  List<CommentEntity> comments = [];

  /// 获取主题
  void getPostContent({
    VoidCallback onStart,
    VoidCallback onFinished,
    DataCallback onData,
  }) {
    onStart?.call();
    asyncRequest(
      netUtil.getPostDetail(id),
      onData: (response) {
        onData?.call(response);
        postDetailEntity = response.data;
        onFinished?.call();
      },
    );
  }

  /// 获取评论
  void getComments({
    VoidCallback onStart,
    VoidCallback onFinished,
    DataCallback onData,
    @required bool refresh,
  }) {
    onStart?.call();
    asyncRequest(
      netUtil.getComments(id, refresh ? 1 : commentPageIndex + 1),
      onData: (response) {
        onData?.call(response);
        _updateComments(response.data, refresh);
        onFinished?.call();
      },
    );
  }

  /// 更新评论
  void _updateComments(CommentListEntity entity, bool refresh) {
    if (refresh) {
      comments = entity.comments;
      commentPageIndex = 1;
      hasMore = true;
      return;
    }
    commentPageIndex++;
    var newList = comments;
    newList.addAll(entity.comments);
    comments = newList;
  }

  /// 构造评论数据体
  Map<String, dynamic> _constructPostData() {
    return {
      'mid': id,
      'phonenumber': Global.phoneNumber,
      'cdate': transferDateWithTime(DateTime.now().toLocal()),
      'cbody': comment,
    };
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

  /// 发表评论
  void postComment({
    VoidCallback onStart,
    VoidCallback onFinished,
    DataCallback onData,
  }) {
    onStart?.call();
    asyncRequest(
      netUtil.postNewComment(_constructPostData()),
      onData: (response) {
        onData?.call(response);
        onFinished?.call();
      },
    );
  }
}
