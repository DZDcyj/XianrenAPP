///
/// my_bottles_page
///
/// created by DZDcyj at 2021/12/16
///
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:xianren_app/base/view/base_page_view.dart';
import 'package:xianren_app/bean/bean.dart';
import 'package:xianren_app/page/homepage/view_model/draft_bottle/my_bottles_page_provider.dart';
import 'package:xianren_app/router/router.dart';

import 'draft_bottle_item.dart';

class MyBottlesPage extends PageNodeProvider<MyBottlesPageProvider> {
  @override
  Widget buildContent(BuildContext context) => _MyBottlesPageContent(mProvider);
}

class _MyBottlesPageContent extends BasePageContentView<MyBottlesPageProvider> {
  _MyBottlesPageContent(MyBottlesPageProvider provider) : super(provider);

  @override
  _MyBottlesPageContentState createState() => _MyBottlesPageContentState();
}

class _MyBottlesPageContentState extends BasePageContentViewState<MyBottlesPageProvider> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      mProvider.getAllBottles(
        true,
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
        title: Text('我的漂流瓶'),
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
              onRefresh: _reloadingBottles,
              child: Selector<MyBottlesPageProvider, Tuple2<bool, List<DraftBottleEntity>>>(
                selector: (_, provider) => Tuple2(provider.loading, provider.bottles),
                builder: (context, tuple, child) {
                  if (tuple.item1) {
                    return CircularProgressIndicator();
                  }
                  var bottles = tuple.item2;
                  return ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: bottles.length + 1,
                    itemBuilder: (context, index) {
                      if (index == bottles.length) {
                        return Selector<MyBottlesPageProvider, Tuple2<bool, bool>>(
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
                                onPressed: null,
                              ),
                              alignment: Alignment.center,
                            );
                          },
                        );
                      }
                      return DraftBottleItem(
                        id: bottles[index].id,
                        content: bottles[index].content,
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

  /// 刷新瓶子
  Future<void> _reloadingBottles() async {
    mProvider.getAllBottles(
      true,
      onStart: () => mProvider.loading = true,
      onFinished: () => mProvider.loading = false,
    );
  }
}
