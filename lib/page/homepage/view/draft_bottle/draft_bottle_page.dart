///
/// draft_bottle_page
///
/// created by DZDcyj at 2021/12/15
///
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xianren_app/base/view/base_page_view.dart';
import 'package:xianren_app/constants/constants.dart';
import 'package:xianren_app/page/homepage/view_model/draft_bottle/draft_bottle_page_provider.dart';
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
              icon: Image.asset('assets/my-bottles.png'),
              onPressed: _showThrowBottleDialog,
              iconSize: 100.0,
            ),
            Expanded(child: Container()),
            IconButton(
              icon: Image.asset('assets/basket.png'),
              onPressed: () => RouteWrapper.pushNamed(context, routerNameMyBottlesPage),
              iconSize: 100.0,
            ),
          ],
        ),
      ),
    );
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
            showToast(msg: '您的漂流瓶已经飘向远方……');
          }
        },
      );
    }
  }
}
