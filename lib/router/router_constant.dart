///
/// router_constant
///
/// created by DZDcyj at 2021/9/14
///
import 'package:flutter/cupertino.dart';
import 'package:xianren_app/page/draft_bottle/view/draft_bottle_detail.dart';
import 'package:xianren_app/page/draft_bottle/view/my_bottles_page.dart';
import 'package:xianren_app/page/homepage/view/homepage.dart';
import 'package:xianren_app/page/login_page/view/login_page.dart';
import 'package:xianren_app/page/login_page/view/register_page.dart';
import 'package:xianren_app/page/personal_information/view/my_post_page.dart';
import 'package:xianren_app/page/personal_information/view/personal_information_modify_page.dart';
import 'package:xianren_app/page/personal_information/view/personal_information_page.dart';
import 'package:xianren_app/page/tree_hole/view/new_post_page.dart';
import 'package:xianren_app/page/tree_hole/view/post_detail.dart';

const String routerNameHomePage = 'homepage';
const String routerNameLoginPage = 'loginpage';
const String routerNameRegisterPage = 'registerpage';
const String routerNamePersonalInformationPage = 'personalinformationpage';
const String routerNamePersonalInformationModifyPage = 'personalinformationmodifypage';
const String routerNameNewPostPage = 'newpostpage';
const String routerNamePostDetail = 'postdetail';
const String routerNameMyPostPage = 'mypostpage';
const String routerNameMyBottlesPage = 'mybottlespage';
const String routerNameBottleDetail = 'bottledetail';

final Map<String, Widget Function({List<dynamic> params})> routerMap = {
  routerNameHomePage: ({params}) => HomePage(),
  routerNameLoginPage: ({params}) => LoginPage(),
  routerNameRegisterPage: ({params}) => RegisterPage(),
  routerNamePersonalInformationPage: ({params}) => PersonalInformationPage(),
  routerNamePersonalInformationModifyPage: ({params}) {
    return PersonalInformationModifyPage(
      params[0],
      params[1],
      params[2],
      params[3],
      params[4],
    );
  },
  routerNameNewPostPage: ({params}) => NewPostPage(params[0]),
  routerNamePostDetail: ({params}) => PostDetail(params[0]),
  routerNameMyPostPage: ({params}) => MyPostPage(),
  routerNameMyBottlesPage: ({params}) => MyBottlesPage(),
  routerNameBottleDetail: ({params}) => DraftBottleDetail(params[0]),
};
