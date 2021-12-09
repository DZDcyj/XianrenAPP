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
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      mProvider.getPostsFromServer(
        onStart: () => mProvider.isLoading = true,
        onFinished: () => mProvider.isLoading = false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: EdgeInsets.only(left: 40.0, right: 40.0),
      child: RefreshIndicator(
        // TODO: 添加下划加载更多
        onRefresh: _reloadingPosts,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Selector<TreeHolePageProvider, Tuple2<bool, List<PostEntity>>>(
            selector: (_, provider) => Tuple2(provider.isLoading, provider.posts),
            builder: (context, tuple, child) {
              if (tuple.item1) {
                return CircularProgressIndicator();
              }
              var posts = tuple.item2;
              return Column(
                children: List.generate(
                  posts.length ?? 0,
                  (index) => PostItem(
                    anonymousName: posts[index].anonymousName,
                    title: posts[index].title,
                    date: posts[index].date,
                  ),
                ),
              );
            },
          ),
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
