///
/// app_module
///
/// created by DZDcyj at 2021/11/28
///
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dartin/dartin.dart';
import 'package:flutter/cupertino.dart' as flutter;
import 'package:xianren_app/page/draft_bottle/view_model/draft_bottle_detail_provider.dart';
import 'package:xianren_app/page/draft_bottle/view_model/draft_bottle_page_provider.dart';
import 'package:xianren_app/page/draft_bottle/view_model/my_bottles_page_provider.dart';
import 'package:xianren_app/page/homepage/view_model/homepage_provider.dart';
import 'package:xianren_app/page/init_page/view_model/init_page_provider.dart';
import 'package:xianren_app/page/login_page/view_model/login_page_provider.dart';
import 'package:xianren_app/page/login_page/view_model/register_page_provider.dart';
import 'package:xianren_app/page/personal_information/view_model/my_post_page_provider.dart';
import 'package:xianren_app/page/personal_information/view_model/personal_information_modify_page_provider.dart';
import 'package:xianren_app/page/personal_information/view_model/personal_information_page_provider.dart';
import 'package:xianren_app/page/tree_hole/view_model/new_post_page_provider.dart';
import 'package:xianren_app/page/tree_hole/view_model/post_detail_provider.dart';
import 'package:xianren_app/page/tree_hole/view_model/tree_hole_page_provider.dart';
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
  factory<PersonalInformationModifyPageProvider>(
    ({params}) => PersonalInformationModifyPageProvider(
      params.get(0),
      params.get(1),
      params.get(2),
      params.get(3),
      params.get(4),
    ),
  ),
  factory<NewPostPageProvider>(
    ({params}) => NewPostPageProvider(params.get(0)),
  ),
  factory<TreeHolePageProvider>(
    ({params}) => TreeHolePageProvider(),
  ),
  factory<PostDetailProvider>(
    ({params}) => PostDetailProvider(params.get(0)),
  ),
  factory<MyPostPageProvider>(
    ({params}) => MyPostPageProvider(),
  ),
  factory<DraftBottlePageProvider>(
    ({params}) => DraftBottlePageProvider(),
  ),
  factory<MyBottlesPageProvider>(
    ({params}) => MyBottlesPageProvider(),
  ),
  factory<DraftBottleDetailProvider>(
    ({params}) => DraftBottleDetailProvider(params.get(0)),
  ),
]);

final utilModule = Module([
  single<NetUtil>(({params}) => NetUtil()),
  single<flutter.NavigatorObserver>(({params}) => flutter.NavigatorObserver()),
  single<CookieJar>(({params}) => CookieJar()),
]);

final appModule = [viewModelModule, utilModule];
