///
/// router_constant
///
/// created by DZDcyj at 2021/9/14
///
import 'package:flutter/cupertino.dart';
import 'package:xianren_app/page/homepage/view/homepage.dart';
import 'package:xianren_app/page/login_page/view/login_page.dart';
import 'package:xianren_app/page/login_page/view/register_page.dart';

const String routerNameHomePage = 'homepage';
const String routerNameLoginPage = 'loginpage';
const String routerNameRegisterPage = 'registerpage';

final Map<String, Widget Function({List<dynamic> params})> routerMap = {
  routerNameHomePage: ({params}) => HomePage(params[0]),
  routerNameLoginPage: ({params}) => LoginPage(),
  routerNameRegisterPage: ({params}) => RegisterPage(),
};
