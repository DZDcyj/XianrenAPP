///
/// init_page
///
/// created by DZDcyj at 2021/11/28
///
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:xianren_app/base/view/base_page_view.dart';
import 'package:xianren_app/page/init_page/view_model/init_page_provider.dart';
import 'package:xianren_app/router/router.dart';
import 'package:xianren_app/router/router_constant.dart';

class InitPage extends PageNodeProvider<InitPageProvider> {
  @override
  Widget buildContent(BuildContext context) => _InitPageContent(mProvider);
}

class _InitPageContent extends BasePageContentView<InitPageProvider> {
  _InitPageContent(InitPageProvider provider) : super(provider);

  @override
  _InitPageContentState createState() => _InitPageContentState();
}

class _InitPageContentState extends BasePageContentViewState<InitPageProvider> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 1)).then((_) {
        RouteWrapper.popAndPushNamed(routerNameLoginPage);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Center(
        child: Text(
          'Welcome to Xianren APP!',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
