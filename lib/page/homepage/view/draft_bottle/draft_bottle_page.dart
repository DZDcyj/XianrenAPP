///
/// draft_bottle_page
///
/// created by DZDcyj at 2021/12/15
///
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xianren_app/base/view/base_page_view.dart';
import 'package:xianren_app/page/homepage/view_model/draft_bottle/draft_bottle_page_provider.dart';

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
              onPressed: () => showToast(msg: '我是瓶子'),
              iconSize: 100.0,
            ),
            Expanded(child: Container()),
            IconButton(
              icon: Image.asset('assets/basket.png'),
              onPressed: () => showToast(msg: '我是篮子'),
              iconSize: 100.0,
            ),
          ],
        ),
      ),
    );
  }
}
