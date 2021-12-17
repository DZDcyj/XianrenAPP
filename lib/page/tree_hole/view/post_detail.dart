///
/// post_detail
///
/// created by DZDcyj at 2021/12/11
///
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:xianren_app/base/view/base_page_view.dart';
import 'package:xianren_app/bean/bean.dart';
import 'package:xianren_app/page/tree_hole/view/poster_item.dart';
import 'package:xianren_app/page/tree_hole/view_model/post_detail_provider.dart';
import 'package:xianren_app/router/router.dart';

import 'comment_item.dart';

class PostDetail extends PageNodeProvider<PostDetailProvider> {
  PostDetail(this.id) : super(params: [id]);
  final int id;

  Widget buildContent(BuildContext context) => _PostDetailContent(mProvider);
}

class _PostDetailContent extends BasePageContentView<PostDetailProvider> {
  _PostDetailContent(PostDetailProvider provider) : super(provider);

  @override
  _PostDetailContentState createState() => _PostDetailContentState();
}

class _PostDetailContentState extends BasePageContentViewState<PostDetailProvider> {
  TextEditingController _textEditingController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      mProvider.getPostContent(
        onStart: () => mProvider.loadingPoster = true,
        onFinished: () => mProvider.loadingPoster = false,
      );
      mProvider.getComments(
        onStart: () => mProvider.loadingComments = true,
        onFinished: () => mProvider.loadingComments = false,
        refresh: true,
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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('帖子详情'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          onPressed: () => RouteWrapper.popSafety(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 30.0, right: 30.0),
          child: Center(
            child: _content(),
          ),
        ),
      ),
    );
  }

  /// 处理刷新
  Future<void> _refreshHandler() async {
    mProvider.getComments(
      refresh: true,
      onStart: () => mProvider.loadingComments = true,
      onFinished: () => mProvider.loadingComments = false,
    );
  }

  /// 主要内容
  Widget _content() {
    return RefreshIndicator(
      onRefresh: _refreshHandler,
      child: Selector<PostDetailProvider, bool>(
        selector: (_, provider) => provider.loadingPoster,
        builder: (context, loading, child) {
          if (loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: _contents(),
                ),
              ),
              _commentInput(),
            ],
          );
        },
      ),
    );
  }

  /// 楼主
  Widget _poster() {
    return PosterItem(
      entity: mProvider.postDetailEntity,
    );
  }

  /// 加载更多
  void _handleLoadMore() {
    mProvider.getComments(
      refresh: false,
      onStart: () => mProvider.loadingMoreComments = true,
      onFinished: () => mProvider.loadingMoreComments = false,
      onData: (response) => mProvider.hasMore = response.data.comments.isNotEmpty,
    );
  }

  /// 所有可滑动内容，包含主题与回复
  Widget _contents() {
    return Column(
      children: [
        _poster(),
        SizedBox(height: 10.0),
        SizedBox(height: 1.0, child: Container(color: Colors.grey)),
        SizedBox(height: 10.0),
        Selector<PostDetailProvider, Tuple2<bool, List<CommentEntity>>>(
          selector: (_, provider) => Tuple2(provider.loadingComments, provider.comments),
          builder: (context, tuple, child) {
            var loading = tuple.item1;
            var comments = tuple.item2;
            if (loading) {
              return Center(
                child: SizedBox(
                  width: 30.0,
                  height: 30.0,
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: comments.length + 1,
              itemBuilder: (context, index) {
                if (index == comments.length) {
                  return Selector<PostDetailProvider, Tuple2<bool, bool>>(
                    selector: (_, provider) => Tuple2(provider.loadingMoreComments, provider.hasMore),
                    builder: (context, tuple, child) {
                      var loadingMore = tuple.item1;
                      var hasMore = tuple.item2;
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
                return CommentItem(
                  anonymousName: comments[index].anonymousName,
                  date: comments[index].date,
                  body: comments[index].body,
                );
              },
            );
          },
        ),
      ],
    );
  }

  /// 发表回复框
  Widget _commentInput() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                border: Border.all(color: Colors.grey),
              ),
              child: TextField(
                minLines: 1,
                maxLines: 5,
                controller: _textEditingController,
                onChanged: (value) => mProvider.comment = value,
                decoration: InputDecoration(
                  hintText: '请发表您的高见',
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.multiline,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _publishComment,
            child: Text('发布'),
          ),
        ],
      ),
    );
  }

  /// 发表评论
  void _publishComment() {
    if (mProvider.validateComment(
      callback: (message) => showToast(msg: message),
    )) {
      mProvider.postComment(
        onStart: startLoading,
        onData: (response) {
          if (response.status) {
            _textEditingController.clear();
            mProvider.comment = '';
            showToast(msg: '回复成功！');
            _refreshHandler();
          }
        },
        onFinished: finishLoading,
      );
    }
  }
}
