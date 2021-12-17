///
/// draft_bottle_page
///
/// created by DZDcyj at 2021/12/15
///
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xianren_app/base/view/base_page_view.dart';
import 'package:xianren_app/bean/bean.dart';
import 'package:xianren_app/constants/constants.dart';
import 'package:xianren_app/page/draft_bottle/view_model/draft_bottle_page_provider.dart';
import 'package:xianren_app/router/router.dart';
import 'package:xianren_app/router/router_constant.dart';

class DraftBottlePage extends PageNodeProvider<DraftBottlePageProvider> {
  @override
  Widget buildContent(BuildContext context) => _DraftBottlePageContent(mProvider);
}

class _DraftBottlePageContent extends BasePageContentView<DraftBottlePageProvider> {
  _DraftBottlePageContent(DraftBottlePageProvider provider) : super(provider);

  _DraftBottlePageContentView createState() => _DraftBottlePageContentView();
}

class _DraftBottlePageContentView extends BasePageContentViewState<DraftBottlePageProvider> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/beach-background.jpg'),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Image.asset('assets/fishing-net.png'),
                      iconSize: 100.0,
                      onPressed: _handleScoopBottle,
                    ),
                    Text('捞一个漂流瓶'),
                  ],
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  children: [
                    IconButton(
                      icon: Image.asset('assets/my-bottles.png'),
                      onPressed: _showThrowBottleDialog,
                      iconSize: 100.0,
                    ),
                    Text('丢一个漂流瓶'),
                  ],
                ),
                Expanded(child: Container()),
                Column(
                  children: [
                    IconButton(
                      icon: Image.asset('assets/basket.png'),
                      onPressed: () => RouteWrapper.pushNamed(context, routerNameMyBottlesPage),
                      iconSize: 100.0,
                    ),
                    Text('我的漂流瓶'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 捞瓶子
  void _handleScoopBottle() {
    mProvider.scoopBottle(
      onStart: startLoading,
      onData: _handleScoopedBottle,
      onFinished: finishLoading,
    );
  }

  /// 处理捞到的瓶子
  Future<void> _handleScoopedBottle(dynamic response) async {
    if (response.code == responseOK) {
      DraftBottleEntity entity = response.data;
      var content = entity.content;
      if (content?.isEmpty ?? true) {
        return;
      }
      var result = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('捞到了一个漂流瓶！'),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop('cancel'),
                child: Text('扔回大海'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop('collect'),
                child: Text('放进篮子'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop('destroy'),
                child: Text('销毁'),
              ),
            ],
          );
        },
      );
      switch (result) {
        case 'collect':
          mProvider.collectBottle(entity.id, onStart: startLoading, onFinished: finishLoading);
          break;
        case 'destroy':
          mProvider.destroyBottle(entity.id, onStart: startLoading, onFinished: finishLoading);
          break;
        case 'cancel':
          showToast(msg: '这个瓶子又漂回了大海深处……');
          break;
        default:
          showToast(msg: '这个瓶子又漂回了大海深处……');
      }
    } else if (response.code == responseSessionInvalid) {
      showToast(msg: '会话过期，请重新登录！');
      RouteWrapper.backToLoginPage(context);
    } else {
      showToast(msg: '发生错误！(${response.code})');
    }
  }

  /// 丢漂流瓶的对话框
  Future<void> _showThrowBottleDialog() async {
    String content = await showDialog(
      context: context,
      builder: (context) {
        String bottleContent;
        return AlertDialog(
          title: Text('扔一个漂流瓶'),
          content: TextField(
            minLines: 1,
            maxLines: 5,
            decoration: InputDecoration(
              labelText: '漂流瓶内容',
              hintText: '在此输入您想要传达的内容吧',
              prefixIcon: Icon(Icons.mail),
            ),
            onChanged: (value) => bottleContent = value,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('取消'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(bottleContent),
              child: Text('确认'),
            ),
          ],
        );
      },
    );
    if (content?.isNotEmpty ?? false) {
      mProvider.throwBottle(
        content,
        onStart: startLoading,
        onFinished: finishLoading,
        onData: (response) {
          if (response.code == responseOK) {
            showToast(msg: '您的漂流瓶已经漂向远方……');
          }
        },
      );
    }
  }
}
