///
/// homepage
///
/// created by DZDcyj at 2021/11/28
///
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xianren_app/base/view/base_page_view.dart';
import 'package:xianren_app/page/draft_bottle/view/draft_bottle_page.dart';
import 'package:xianren_app/page/homepage/view_model/homepage_provider.dart';
import 'package:xianren_app/page/personal_information/view/personal_information_page.dart';
import 'package:xianren_app/page/tree_hole/view/tree_hole_page.dart';
import 'package:xianren_app/router/router.dart';
import 'package:xianren_app/router/router_constant.dart';
import 'package:xianren_app/utils/global_util.dart';

class HomePage extends PageNodeProvider<HomePageProvider> {
  HomePage() : super();

  @override
  Widget buildContent(BuildContext context) => _HomePageContent(mProvider);
}

class _HomePageContent extends BasePageContentView<HomePageProvider> {
  _HomePageContent(HomePageProvider provider) : super(provider);

  @override
  _MyHomePageContentState createState() => _MyHomePageContentState();
}

class _MyHomePageContentState extends BasePageContentViewState<HomePageProvider> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Selector<HomePageProvider, int>(
            selector: (_, provider) => provider.currIndex,
            builder: (context, index, child) {
              switch (index) {
                case 0:
                  return DraftBottlePage();
                case 1:
                  return TreeHolePage();
                default:
                  return PersonalInformationPage();
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: Selector<HomePageProvider, int>(
        selector: (_, provider) => provider.currIndex,
        builder: (context, index, child) => BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: _icon('beach', index == 0),
              label: '?????????',
            ),
            BottomNavigationBarItem(
              icon: _icon('forum', index == 1),
              label: '??????',
            ),
            BottomNavigationBarItem(
              icon: _icon('self', index == 2),
              label: '??????',
            ),
          ],
          currentIndex: index,
          onTap: (newIndex) => mProvider.currIndex = newIndex,
        ),
      ),
      floatingActionButton: Selector<HomePageProvider, int>(
        selector: (_, provider) => provider.currIndex,
        builder: (context, index, child) {
          if (index == 1) {
            return FloatingActionButton(
              onPressed: _postNewPost,
              child: Icon(Icons.forum),
            );
          }
          return Container();
        },
      ),
    );
  }

  /// ?????????????????????
  void _postNewPost() {
    RouteWrapper.pushNamed(context, routerNameNewPostPage, arguments: [Global.phoneNumber]);
  }

  /// ???????????????
  /// [name] ????????????????????? assets ??????
  /// [selected] ????????????????????????
  Widget _icon(String name, bool selected) {
    String suffix = selected ? '-selected' : '';
    String fullName = 'assets/$name$suffix.png';
    return Container(
      width: selected ? 48.0 : 36.0,
      child: Image(image: AssetImage(fullName)),
    );
  }
}
