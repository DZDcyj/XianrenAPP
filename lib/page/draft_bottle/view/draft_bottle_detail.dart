///
/// draft_bottle_detail
///
/// created by DZDcyj at 2021/12/16
///
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:xianren_app/base/view/base_page_view.dart';
import 'package:xianren_app/page/draft_bottle/view/draft_bottle_comment_item.dart';
import 'package:xianren_app/page/draft_bottle/view/draft_bottle_poster_item.dart';
import 'package:xianren_app/page/draft_bottle/view_model/draft_bottle_detail_provider.dart';
import 'package:xianren_app/router/router.dart';

class DraftBottleDetail extends PageNodeProvider<DraftBottleDetailProvider> {
  DraftBottleDetail(this.id) : super(params: [id]);

  final int id;

  @override
  Widget buildContent(BuildContext context) => _DraftBottleDetailContent(mProvider);
}

class _DraftBottleDetailContent extends BasePageContentView<DraftBottleDetailProvider> {
  _DraftBottleDetailContent(DraftBottleDetailProvider provider) : super(provider);

  @override
  _DraftBottleDetailContentState createState() => _DraftBottleDetailContentState();
}

class _DraftBottleDetailContentState extends BasePageContentViewState<DraftBottleDetailProvider> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      mProvider.getBottleDetail(
        onStart: () => mProvider.loading = true,
        onFinished: () => mProvider.loading = false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('漂流瓶详情'),
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
    mProvider.getBottleDetail(
      onStart: () => mProvider.loading = true,
      onFinished: () => mProvider.loading = false,
    );
  }

  /// 主要内容
  Widget _content() {
    return RefreshIndicator(
      onRefresh: _refreshHandler,
      child: Selector<DraftBottleDetailProvider, bool>(
        selector: (_, provider) => provider.loading,
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

  /// 瓶主
  Widget _poster() {
    return DraftBottlePosterItem(content: mProvider.bottleContent);
  }

  /// 所有可滑动内容，包含主题与回复
  Widget _contents() {
    return Column(
      children: [
        _poster(),
        SizedBox(height: 10.0),
        SizedBox(height: 1.0, child: Container(color: Colors.grey)),
        SizedBox(height: 10.0),
        Selector<DraftBottleDetailProvider, Tuple2<bool, List<String>>>(
          selector: (_, provider) => Tuple2(provider.loading, provider.comments),
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
                  return Container(
                    child: TextButton(
                      child: Text(
                        '没有更多啦',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.grey,
                        ),
                      ),
                      onPressed: null,
                    ),
                    alignment: Alignment.center,
                  );
                }
                return DraftBottleCommentItem(content: comments[index]);
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
      mProvider.commentBottle(
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
