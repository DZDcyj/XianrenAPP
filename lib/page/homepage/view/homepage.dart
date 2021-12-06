///
/// homepage
///
/// created by DZDcyj at 2021/11/28
///
import 'package:xianren_app/base/view/base_page_view.dart';
import 'package:xianren_app/page/homepage/view/personal_information_page.dart';
import 'package:xianren_app/page/homepage/view_model/homepage_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Selector<HomePageProvider, int>(
              selector: (_, provider) => provider.currIndex,
              builder: (context, index, child) {
                if (index != 2) {
                  return Text(
                    'You are now at page $index',
                  );
                }
                return PersonalInformationPage();
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Selector<HomePageProvider, int>(
        selector: (_, provider) => provider.currIndex,
        builder: (context, index, child) => BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: _icon('label', index == 0),
              label: '小纸条',
            ),
            BottomNavigationBarItem(
              icon: _icon('forum', index == 1),
              label: '树洞',
            ),
            BottomNavigationBarItem(
              icon: _icon('self', index == 2),
              label: '我的',
            ),
          ],
          currentIndex: index,
          onTap: (newIndex) => mProvider.currIndex = newIndex,
        ),
      ),
    );
  }

  /// 导航栏图标
  /// [name] 图片名称，不接 assets 前缀
  /// [selected] 是否选中当前栏位
  Widget _icon(String name, bool selected) {
    String suffix = selected ? '-selected' : '';
    String fullName = 'assets/$name$suffix.png';
    return Container(
      width: selected ? 48.0 : 36.0,
      child: Image(image: AssetImage(fullName)),
    );
  }
}
