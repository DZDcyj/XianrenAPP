///
/// tree_hole_page_provider
///
/// created by DZDcyj at 2021/12/9
///
import 'package:dartin/dartin.dart';
import 'package:xianren_app/base/view_model/base_page_view_provider.dart';
import 'package:xianren_app/bean/bean.dart';
import 'package:xianren_app/constants/constants.dart';
import 'package:xianren_app/utils/net_util.dart';

class TreeHolePageProvider extends BasePageProvider {
  bool _isLoading;

  bool get isLoading => _isLoading ?? false;

  set isLoading(bool value) {
    _isLoading = value;
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
  void getPostsFromServer({
    void Function() onStart,
    void Function(dynamic data) onData,
    void Function() onFinished,
    bool refresh = true,
  }) {
    onStart?.call();
    asyncRequest(
      netUtil.getPosts(pageIndex),
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
      return;
    }
    var newList = posts;
    pageIndex++;
    newList.addAll(list.posts);
    posts = newList;
  }
}
