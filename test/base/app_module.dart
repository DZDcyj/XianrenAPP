///
/// app_module
///
/// created by DZDcyj at 2021/11/28
///
import 'package:xianren_app/page/homepage/view_model/homepage_provider.dart';
import 'package:xianren_app/page/init_page/view_model/init_page_provider.dart';
import 'package:xianren_app/page/login_page/view_model/login_page_provider.dart';
import 'package:xianren_app/utils/net_util.dart';
import 'package:dartin/dartin.dart';
import 'package:mockito/mockito.dart';

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
]);

class NetUtilMock extends Mock implements NetUtil {}

final utilModule = Module([
  single<NetUtil>(({params}) => NetUtilMock()),
]);

final appModule = [viewModelModule, utilModule];

void init() {
  startDartIn(appModule);
}
