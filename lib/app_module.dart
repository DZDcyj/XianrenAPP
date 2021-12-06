///
/// app_module
///
/// created by DZDcyj at 2021/11/28
///
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dartin/dartin.dart';
import 'package:flutter/cupertino.dart' as flutter;
import 'package:xianren_app/page/homepage/view_model/homepage_provider.dart';
import 'package:xianren_app/page/homepage/view_model/personal_information_page_provider.dart';
import 'package:xianren_app/page/init_page/view_model/init_page_provider.dart';
import 'package:xianren_app/page/login_page/view_model/login_page_provider.dart';
import 'package:xianren_app/page/login_page/view_model/register_page_provider.dart';
import 'package:xianren_app/utils/net_util.dart';

final viewModelModule = Module([
  factory<HomePageProvider>(
    ({params}) => HomePageProvider(),
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
  factory<PersonalInformationPageProvider>(
    ({params}) => PersonalInformationPageProvider(),
  ),
]);

final utilModule = Module([
  single<NetUtil>(({params}) => NetUtil()),
  single<flutter.NavigatorObserver>(({params}) => flutter.NavigatorObserver()),
  single<CookieJar>(({params}) => CookieJar()),
]);

final appModule = [viewModelModule, utilModule];
