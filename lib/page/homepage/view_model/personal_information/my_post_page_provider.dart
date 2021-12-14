///
/// my_post_page_provider
///
/// created by DZDcyj at 2021/12/14
///
import 'package:dartin/dartin.dart';
import 'package:flutter/material.dart';
import 'package:xianren_app/base/view_model/base_page_view_provider.dart';
import 'package:xianren_app/bean/bean.dart';
import 'package:xianren_app/constants/constants.dart';
import 'package:xianren_app/utils/net_util.dart';

class MyPostPageProvider extends BasePageProvider {
  /// 加载所有
  bool _isLoading;

  bool get isLoading => _isLoading ?? false;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// 加载更多
  bool _loadingMore;

  bool get loadingMore => _loadingMore ?? false;

  set loadingMore(bool value) {
    _loadingMore = value;
    notifyListeners();
  }

  /// 是否有更多
  bool _hasMore;

  bool get hasMore => _hasMore ?? true;

  set hasMore(bool value) {
    _hasMore = value;
    notifyListeners();
  }

  int _pageIndex;

  int get pageIndex => _pageIndex ?? 1;

  set pageIndex(int value) {
    _pageIndex = value;
    notifyListeners();
  }

  NetUtil netUtil = inject();

  List<PostEntity> _posts;

  List<PostEntity> get posts => _posts ?? [];

  set posts(List<PostEntity> value) {
    _posts = value;
    notifyListeners();
  }

  /// 从服务器获取帖子数据
  void getUserPostsFromServer({
    VoidCallback onStart,
    DataCallback onData,
    VoidCallback onFinished,
    bool refresh = true,
  }) {
    onStart?.call();
    asyncRequest(
      netUtil.getUserPosts(refresh ? 1 : pageIndex + 1),
      onData: (response) {
        if (response.code == responseOK) {
          updatePosts(response.data, refresh);
          onData?.call(response);
        }
        onFinished?.call();
      },
    );
  }

  /// 更新帖子
  void updatePosts(PostListEntity list, bool refresh) {
    if (refresh) {
      posts = list.posts;
      pageIndex = 1;
      hasMore = true;
      return;
    }
    var newList = posts;
    pageIndex++;
    newList.addAll(list.posts);
    posts = newList;
  }

  /// 删除某条帖子
  void deletePost(
    int id, {
    VoidCallback onStart,
    VoidCallback onFinished,
    DataCallback onData,
  }) {
    onStart?.call();
    asyncRequest(
      netUtil.deletePost(id),
      onData: (response) {
        onData?.call(response);
        onFinished?.call();
      },
    );
  }
}
