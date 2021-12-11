///
/// post_detail
///
/// created by DZDcyj at 2021/12/11
///
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:xianren_app/base/view/base_page_view.dart';
import 'package:xianren_app/bean/bean.dart';
import 'package:xianren_app/page/homepage/view/tree_hole/comment_item.dart';
import 'package:xianren_app/page/homepage/view_model/tree_hole/post_detail_provider.dart';
import 'package:xianren_app/router/router.dart';

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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Center(
          child: _content(),
        ),
      ),
    );
  }

  /// 主要内容
  Widget _content() {
    return Selector<PostDetailProvider, bool>(
      selector: (_, provider) => provider.loadingPoster,
      builder: (context, loading, child) {
        if (loading) {
          return CircularProgressIndicator();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _poster(),
            _comments(),
            _commentInput(),
          ],
        );
      },
    );
  }

  /// 楼主
  Widget _poster() {
    throw UnimplementedError();
  }

  /// 回复
  Widget _comments() {
    return Selector<PostDetailProvider, Tuple2<bool, List<CommentEntity>>>(
      selector: (_, provider) => Tuple2(provider.loadingComments, provider.comments),
      builder: (context, tuple, child) {
        var loading = tuple.item1;
        var comments = tuple.item2;
        if (loading) {
          return CircularProgressIndicator();
        }
        return ListView.builder(
          itemCount: comments.length + 1,
          itemBuilder: (context, index) {
            if (index == comments.length) {
              return Selector<PostDetailProvider, Tuple2<bool, bool>>(
                selector: (_, provider) => Tuple2(provider.loadingMoreComments, provider.hasMore),
                builder: (context, tuple, child) {
                  var loadingMore = tuple.item1;
                  var hasMore = tuple.item2;
                  if (loadingMore) {
                    return CircularProgressIndicator();
                  }
                  return Text(hasMore ? '下拉加载更多' : '没有更多了哦');
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
    );
  }

  /// 发表回复框
  Widget _commentInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(),
        ),
        ElevatedButton(
          onPressed: () => showToast(msg: '开发中'),
          child: Text('发布'),
        ),
      ],
    );
  }
}
