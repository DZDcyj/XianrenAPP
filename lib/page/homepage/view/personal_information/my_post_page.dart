///
/// my_post_page
///
/// created by DZDcyj at 2021/12/14
///
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:xianren_app/base/view/base_page_view.dart';
import 'package:xianren_app/bean/bean.dart';
import 'package:xianren_app/page/homepage/view_model/personal_information/my_post_page_provider.dart';
import 'package:xianren_app/router/router.dart';

import 'my_post_item.dart';

class MyPostPage extends PageNodeProvider<MyPostPageProvider> {
  Widget buildContent(BuildContext context) => _MyPostPageContent(mProvider);
}

class _MyPostPageContent extends BasePageContentView<MyPostPageProvider> {
  _MyPostPageContent(MyPostPageProvider provider) : super(provider);

  @override
  _MyPostPageContentView createState() => _MyPostPageContentView();
}

class _MyPostPageContentView extends BasePageContentViewState<MyPostPageProvider> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      mProvider.getUserPostsFromServer(
        onStart: () => mProvider.isLoading = true,
        onFinished: () => mProvider.isLoading = false,
      );
      _scrollController.addListener(_controllerHandler);
    });
  }

  /// 滑动监测
  void _controllerHandler() {
    if (mProvider.hasMore && _scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _handleLoadMore();
    }
  }

  /// 处理上滑加载更多
  void _handleLoadMore() {
    mProvider.getUserPostsFromServer(
      onStart: () => mProvider.loadingMore = true,
      refresh: false,
      onData: (response) => mProvider.hasMore = response.data.posts.isNotEmpty,
      onFinished: _handleLoadMoreFinished,
    );
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
    return Scaffold(
      appBar: AppBar(
        title: Text('我的树洞'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          onPressed: () => RouteWrapper.popSafety(context),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(left: 40.0, right: 40.0),
            child: RefreshIndicator(
              onRefresh: _reloadingPosts,
              child: Selector<MyPostPageProvider, Tuple2<bool, List<PostEntity>>>(
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
                        return Selector<MyPostPageProvider, Tuple2<bool, bool>>(
                          selector: (_, provider) => Tuple2(provider.hasMore, provider.loadingMore),
                          builder: (context, tuple2, child) {
                            var hasMore = tuple2.item1;
                            var loadingMore = tuple2.item2;
                            if (loadingMore) {
                              return Center(
                                child: SizedBox(
                                  width: 30.0,
                                  height: 30.0,
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            var hint = hasMore ? '加载更多' : '没有更多啦';
                            return Container(
                              child: TextButton(
                                child: Text(
                                  hint,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.grey,
                                  ),
                                ),
                                onPressed: hasMore ? _handleLoadMore : null,
                              ),
                              alignment: Alignment.center,
                            );
                          },
                        );
                      }
                      return MyPostItem(
                        id: posts[index].id,
                        anonymousName: posts[index].anonymousName,
                        title: posts[index].title,
                        date: posts[index].date,
                        onDeleteCallback: _handleDeletePost,
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleDeletePost(dynamic postId) {
    // TODO: 删除帖子
    showToast(msg: '你在长按帖子： $postId');
  }

  /// 刷新帖子
  Future<void> _reloadingPosts() async {
    mProvider.getUserPostsFromServer(
      onStart: () => mProvider.isLoading = true,
      onFinished: () => mProvider.isLoading = false,
      refresh: true,
    );
  }
}