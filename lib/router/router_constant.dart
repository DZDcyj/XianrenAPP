///
/// router_constant
///
/// created by DZDcyj at 2021/9/14
///
import 'package:flutter/cupertino.dart';
import 'package:xianren_app/page/homepage/view/homepage.dart';
import 'package:xianren_app/page/homepage/view/personal_information/personal_information_modify_page.dart';
import 'package:xianren_app/page/homepage/view/personal_information/personal_information_page.dart';
import 'package:xianren_app/page/login_page/view/login_page.dart';
import 'package:xianren_app/page/login_page/view/register_page.dart';

const String routerNameHomePage = 'homepage';
const String routerNameLoginPage = 'loginpage';
const String routerNameRegisterPage = 'registerpage';
const String routerNamePersonalInformationPage = 'personalinformationpage';
const String routerNamePersonalInformationModifyPage = 'personalinformationmodifypage';

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
};
