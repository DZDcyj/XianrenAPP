///
/// tree_hole_page
///
/// created by DZDcyj at 2021/12/9
///
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:xianren_app/base/view/base_page_view.dart';
import 'package:xianren_app/bean/bean.dart';
import 'package:xianren_app/page/homepage/view/tree_hole/post_item.dart';
import 'package:xianren_app/page/homepage/view_model/tree_hole/tree_hole_page_provider.dart';

class TreeHolePage extends PageNodeProvider<TreeHolePageProvider> {
  @override
  Widget buildContent(BuildContext context) => _TreeHolePageContent(mProvider);
}

class _TreeHolePageContent extends BasePageContentView<TreeHolePageProvider> {
  _TreeHolePageContent(TreeHolePageProvider provider) : super(provider);

  @override
  BasePageContentViewState<TreeHolePageProvider> createState() => _TreeHolePageContentState();
}

class _TreeHolePageContentState extends BasePageContentViewState<TreeHolePageProvider> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      mProvider.getPostsFromServer(
        onStart: () => mProvider.isLoading = true,
        onFinished: () => mProvider.isLoading = false,
      );
      _scrollController.addListener(_handleLoadMore);
    });
  }

  /// 处理上滑加载更多
  void _handleLoadMore() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      mProvider.getPostsFromServer(
        onStart: () => mProvider.loadingMore = true,
        refresh: false,
        onData: (response) => mProvider.hasMore = response.data.posts.isNotEmpty,
        onFinished: _handleLoadMoreFinished,
      );
    }
  }

  /// 上滑加载完毕后
  void _handleLoadMoreFinished() {
    mProvider.loadingMore = false;
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent - 24.0,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: EdgeInsets.only(left: 40.0, right: 40.0),
      child: RefreshIndicator(
        onRefresh: _reloadingPosts,
        child: Selector<TreeHolePageProvider, Tuple2<bool, List<PostEntity>>>(
          selector: (_, provider) => Tuple2(provider.isLoading, provider.posts),
          builder: (context, tuple, child) {
            if (tuple.item1) {
              return CircularProgressIndicator();
            }
            var posts = tuple.item2;
            return ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              controller: _scrollController,
              itemCount: posts.length + 1,
              itemBuilder: (context, index) {
                if (index == posts.length) {
                  return Selector<TreeHolePageProvider, Tuple2<bool, bool>>(
                    selector: (_, provider) => Tuple2(provider.hasMore, provider.loadingMore),
                    builder: (context, tuple, child) {
                      var hasMore = tuple.item1;
                      var loadingMore = tuple.item2;
                      if (loadingMore) {
                        return Center(
                          child: SizedBox(
                            width: 30.0,
                            height: 30.0,
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      var hint = hasMore ? '下拉加载更多' : '没有更多啦';
                      return Container(
                        child: Text(
                          hint,
                          style: TextStyle(fontSize: 18.0),
                        ),
                        alignment: Alignment.center,
                      );
                    },
                  );
                }
                return PostItem(
                  id: posts[index].id,
                  anonymousName: posts[index].anonymousName,
                  title: posts[index].title,
                  date: posts[index].date,
                );
              },
            );
          },
        ),
      ),
    );
  }

  /// 刷新帖子
  Future<void> _reloadingPosts() async {
    mProvider.getPostsFromServer(
      onStart: () => mProvider.isLoading = true,
      onFinished: () => mProvider.isLoading = false,
      refresh: true,
    );
  }
}
