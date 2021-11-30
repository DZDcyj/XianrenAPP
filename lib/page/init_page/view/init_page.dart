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
      body: Padding(
        padding: EdgeInsets.only(left: 25.0, right: 25.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _welcomeLogo(),
              SizedBox(height: 20.0),
              _welcomeText(),
            ],
          ),
        ),
      ),
    );
  }

  /// 欢迎 Logo
  Widget _welcomeLogo() {
    return Image(image: AssetImage('assets/logo.png'));
  }

  /// 欢迎文字
  Widget _welcomeText() {
    return Text(
      'Welcome to Xianren APP!',
      style: TextStyle(
        fontSize: 28,
      ),
    );
  }
}
