///
/// app_module
///
/// created by DZDcyj at 2021/11/28
///
import 'package:dartin/dartin.dart';
import 'package:flutter/cupertino.dart' as flutter;
import 'package:mockito/mockito.dart';
import 'package:xianren_app/page/homepage/view_model/homepage_provider.dart';
import 'package:xianren_app/page/init_page/view_model/init_page_provider.dart';
import 'package:xianren_app/page/login_page/view_model/login_page_provider.dart';
import 'package:xianren_app/page/login_page/view_model/register_page_provider.dart';
import 'package:xianren_app/utils/net_util.dart';

final viewModelModule = Module([
  factory<HomePageProvider>(
    ({params}) => HomePageProvider(
      params.get(0),
    ),
  ),
  factory<InitPageProvider>(
    ({params}) => InitPageProvider(),
  ),
  factory<LoginPageProvider>(
    ({params}) => LoginPageProvider(),
  ),
  factory<RegisterPageProvider>(
    ({params}) => RegisterPageProvider(),
  ),
]);

class NetUtilMock extends Mock implements NetUtil {}

class NavigatorMock extends Mock implements flutter.NavigatorObserver {}

final utilModule = Module([
  single<NetUtil>(({params}) => NetUtilMock()),
  single<flutter.NavigatorObserver>(({params}) => NavigatorMock()),
]);

final appModule = [viewModelModule, utilModule];

void init() {
  startDartIn(appModule);
}
