///
/// new_post_page
///
/// created by DZDcyj at 2021/12/8
///
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xianren_app/base/view/base_page_view.dart';
import 'package:xianren_app/constants/constants.dart';
import 'package:xianren_app/page/tree_hole/view_model/new_post_page_provider.dart';
import 'package:xianren_app/router/router.dart';

class NewPostPage extends PageNodeProvider<NewPostPageProvider> {
  NewPostPage(this.phoneNumber) : super(params: [phoneNumber]);

  final String phoneNumber;

  @override
  Widget buildContent(BuildContext context) => _NewPostPageContent(mProvider);
}

class _NewPostPageContent extends BasePageContentView<NewPostPageProvider> {
  _NewPostPageContent(NewPostPageProvider provider) : super(provider);

  @override
  BasePageContentViewState<NewPostPageProvider> createState() => _NewPostPageContentState();
}

class _NewPostPageContentState extends BasePageContentViewState<NewPostPageProvider> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text('发表新帖'),
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
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.message),
          onPressed: _publishContent,
        ),
      ),
      onWillPop: _onWillPop,
    );
  }

  /// 退出确认
  Future<bool> _onWillPop() async {
    if ((mProvider.title?.isEmpty ?? true) && (mProvider.content?.isEmpty ?? true)) {
      return true;
    }

    if (mProvider.successfullyPublished ?? false) {
      return true;
    }

    var result = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('退出确认'),
          content: Text('还有内容尚未发布，您确定要退出吗？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('取消'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('确认'),
            ),
          ],
        );
      },
    );
    return result ?? false;
  }

  /// 处理错误信息
  void _stringErrorHandler(String errorMessage) {
    showToast(msg: errorMessage);
  }

  /// 发表内容
  void _publishContent() {
    if (!mProvider.validateData(callback: _stringErrorHandler)) {
      return;
    }
    mProvider.publishPost(
      onStart: startLoading,
      onFinished: finishLoading,
      onData: (response) {
        if (response.status) {
          mProvider.successfullyPublished = true;
          showToast(msg: '发布成功！');
          Navigator.of(context).pop();
        } else {
          if (response.code == responseSessionInvalid) {
            showToast(msg: '会话过期，请重新登录！');
            // TODO: 回退到登陆界面
          } else {
            showToast(msg: '${response.message}(${response.code})');
          }
        }
      },
    );
  }

  /// 组件内容
  Widget _content() {
    return Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _postTitle(),
          SizedBox(height: 1.0, child: Container(color: Colors.grey)),
          _postContent(),
        ],
      ),
    );
  }

  /// 帖子标题
  Widget _postTitle() {
    return TextField(
      decoration: InputDecoration(
        hintText: '为你的帖子想个响亮的标题吧！',
        border: InputBorder.none,
      ),
      style: TextStyle(fontSize: 18.0),
      onChanged: (value) => mProvider.title = value,
    );
  }

  /// 帖子内容
  Widget _postContent() {
    return Container(
      constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height - 250.0),
      child: TextField(
        style: TextStyle(fontSize: 18.0),
        decoration: InputDecoration(
          hintText: '在这里尽情发挥吧！',
          border: InputBorder.none,
        ),
        keyboardType: TextInputType.multiline,
        maxLines: null,
        // 必须显式指定为 null，即无限长度
        onChanged: (value) => mProvider.content = value,
      ),
    );
  }
}
