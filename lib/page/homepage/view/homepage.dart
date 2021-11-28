///
/// homepage
///
/// created by DZDcyj at 2021/11/28
///
import 'package:xianren_app/base/view/base_page_view.dart';
import 'package:xianren_app/page/homepage/view_model/homepage_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends PageNodeProvider<HomePageProvider> {
  HomePage(this.title) : super(params: [title]);

  final String title;

  @override
  Widget buildContent(BuildContext context) => HomePageContent(mProvider);
}

class HomePageContent extends BasePageContentView<HomePageProvider> {
  HomePageContent(
    HomePageProvider provider, {
    Key key,
    this.title,
  }) : super(provider, key: key);

  final String title;

  @override
  _MyHomePageContentState createState() => _MyHomePageContentState();
}

class _MyHomePageContentState extends BasePageContentViewState<HomePageProvider> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(mProvider.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Selector<HomePageProvider, int>(
              selector: (context, provider) => provider.counter,
              builder: (_, count, child) {
                return Text(
                  '$count',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: mProvider.increment,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
